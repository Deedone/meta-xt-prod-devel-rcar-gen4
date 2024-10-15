DESCRIPTION = "Simple application to display a color bar using DRM"
SECTION = "examples"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
	file://drm-color-bar.c \
	file://drmcolorbar.service \
	file://blacklist_rvgc.conf \
	file://load_rvgc.sh \
"

S = "${WORKDIR}"

DEPENDS = "libdrm"
RDEPENDS_${PN} += "bash"

inherit systemd

SYSTEMD_SERVICE:${PN} = "drmcolorbar.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"


CFLAGS += "-I/usr/include/drm"
CFLAGS += "-DWIDTH=1920"
CFLAGS += "-DHEIGHT=1080"

do_compile() {
    ${CC} ${LDFLAGS} ${CFLAGS} drm-color-bar.c -o drm-color-bar -ldrm
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 drm-color-bar ${D}${bindir}

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/drmcolorbar.service ${D}${systemd_system_unitdir}

    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/load_rvgc.sh ${D}${sysconfdir}/init.d

    install -d ${D}/etc/modprobe.d/
    install -m 0644 ${WORKDIR}/blacklist_rvgc.conf ${D}${sysconfdir}/modprobe.d/
}

FILES:${PN} += "${bindir}/drm-color-bar"
FILES:${PN} += "${systemd_system_unitdir}/drmcolorbar.service"
FILES:${PN} += "${sysconfdir}/init.d/load_rvgc.sh "
FILES:${PN} += "${sysconfdir}/modprobe.d/blacklist_rvgc.conf"

