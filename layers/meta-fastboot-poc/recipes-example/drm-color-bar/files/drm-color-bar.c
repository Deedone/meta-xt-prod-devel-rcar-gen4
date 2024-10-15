#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <errno.h>
#include <unistd.h>
#include <sys/mman.h>
#include <xf86drm.h>
#include <xf86drmMode.h>
#include <signal.h>

#ifndef WIDTH
#define WIDTH 1920
#endif
#ifndef HEIGHT
#define HEIGHT 1080
#endif

#define ARGB8888(a, r, g, b) ((uint32_t)((((a) & 0xFF) << 24) | (((r) & 0xFF) << 16) | (((g) & 0xFF) << 8) | ((b) & 0xFF)))

int is_running = 1;

void sigint_handler(int signal)
{
    is_running = 0;
}

void draw_color_bar(uint32_t *buffer, int width, int height, int offset)
{
    int x, y;

    for (y = 0; y < height; y++)
    {
        for (x = 0; x < width; x++)
        {
            // Adjust the position taking into account the offset
            int adjusted_x = (x + offset) % width;
            uint32_t color = 0;

            if (adjusted_x < width / 7)
            {
                color = ARGB8888(0xFF, 0xFF, 0x00, 0x00); // Red
            }
            else if (adjusted_x < (width * 2) / 7)
            {
                color = ARGB8888(0xFF, 0xFF, 0xA5, 0x00); // Orange
            }
            else if (adjusted_x < (width * 3) / 7)
            {
                color = ARGB8888(0xFF, 0xFF, 0xFF, 0x00); // Yellow
            }
            else if (adjusted_x < (width * 4) / 7)
            {
                color = ARGB8888(0xFF, 0x00, 0xFF, 0x00); // Green
            }
            else if (adjusted_x < (width * 5) / 7)
            {
                color = ARGB8888(0xFF, 0x00, 0x00, 0xFF); // Blue
            }
            else if (adjusted_x < (width * 6) / 7)
            {
                color = ARGB8888(0xFF, 0x4B, 0x00, 0x82); // Indigo
            }
            else
            {
                color = ARGB8888(0xFF, 0xEE, 0x82, 0xEE); // Pink
            }

            buffer[y * width + x] = color;
        }
    }
}
int main()
{
    uint32_t time = 0;
    uint32_t offset = 0;
    struct sigaction sa = {0};
    sa.sa_handler = sigint_handler;

    if (sigaction(SIGINT, &sa, NULL) < 0)
    {
        printf("Failed to catch signal\n");
        return -1;
    }

    int fd = open("/dev/dri/card0", O_RDWR | O_CLOEXEC);
    if (fd < 0)
    {
        perror("open");
        return -1;
    }

    drmModeRes *resources = drmModeGetResources(fd);
    if (!resources)
    {
        perror("drmModeGetResources");
        close(fd);
        return -1;
    }

    drmModeConnector *connector = NULL;
    for (int i = 0; i < resources->count_connectors; i++)
    {
        connector = drmModeGetConnector(fd, resources->connectors[i]);
        if (connector->connection == DRM_MODE_CONNECTED)
        {
            break;
        }
        drmModeFreeConnector(connector);
        connector = NULL;
    }

    if (!connector)
    {
        fprintf(stderr, "No connected connector found\n");
        drmModeFreeResources(resources);
        close(fd);
        return -1;
    }

    drmModeEncoder *encoder = drmModeGetEncoder(fd, connector->encoder_id);
    if (!encoder)
    {
        fprintf(stderr, "No encoder found\n");
        drmModeFreeConnector(connector);
        drmModeFreeResources(resources);
        close(fd);
        return -1;
    }

    drmModeCrtc *crtc = drmModeGetCrtc(fd, encoder->crtc_id);
    if (!crtc)
    {
        fprintf(stderr, "No CRTC found\n");
        drmModeFreeEncoder(encoder);
        drmModeFreeConnector(connector);
        drmModeFreeResources(resources);
        close(fd);
        return -1;
    }

    struct drm_mode_create_dumb create_req = {
        .width = WIDTH,
        .height = HEIGHT,
        .bpp = 32,
    };
    drmIoctl(fd, DRM_IOCTL_MODE_CREATE_DUMB, &create_req);

    struct drm_mode_map_dumb map_req = {
        .handle = create_req.handle,
    };
    drmIoctl(fd, DRM_IOCTL_MODE_MAP_DUMB, &map_req);

    uint32_t *buffer = mmap(0, create_req.size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, map_req.offset);
    if (buffer == MAP_FAILED)
    {
        perror("mmap");
        drmModeFreeCrtc(crtc);
        drmModeFreeEncoder(encoder);
        drmModeFreeConnector(connector);
        drmModeFreeResources(resources);
        close(fd);
        return -1;
    }

    struct drm_mode_fb_cmd fb = {
        .width = WIDTH,
        .height = HEIGHT,
        .bpp = 32,
        .pitch = WIDTH * 4,
        .depth = 24,
        .handle = create_req.handle,
    };

    drmVBlank vblank = {};

    do
    {
        draw_color_bar(buffer, WIDTH, HEIGHT, offset);
        offset += 1;
        if (offset >= WIDTH)
        {
            offset = 0;
        }

        drmIoctl(fd, DRM_IOCTL_MODE_ADDFB, &fb);

        if (drmModeSetCrtc(fd, crtc->crtc_id, fb.fb_id, 0, 0, &connector->connector_id, 1, &crtc->mode))
        {
            perror("Cannot set CRTC");
            is_running = 0;
            break;
        }

        // Wait for vsync
        vblank.request.type = DRM_VBLANK_RELATIVE;
        vblank.request.sequence = 1;
        if (drmIoctl(fd, DRM_IOCTL_WAIT_VBLANK, &vblank) < 0) {
            perror("DRM_IOCTL_WAIT_VBLANK");
            exit(1);
        }

    } while (is_running);

    printf("Performing Clean-up\n");

    drmModeRmFB(fd, fb.fb_id);
    munmap(buffer, create_req.size);

    struct drm_mode_destroy_dumb destroy_req = {
        .handle = create_req.handle,
    };
    drmIoctl(fd, DRM_IOCTL_MODE_DESTROY_DUMB, &destroy_req);

    drmModeFreeCrtc(crtc);
    drmModeFreeEncoder(encoder);
    drmModeFreeConnector(connector);
    drmModeFreeResources(resources);
    close(fd);

    return 0;
}
