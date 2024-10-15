# meta-fastboot-poc

## Summary
This article describes the steps to build a Yocto environment for fastboot_demo.

## Reference information
 - [1] Linux Interface Specification Yocto recipe Start-Up Guide from SDK (r11uz0270ej0616-yocto.pdf)

## Building Procedure
Additional files for fastboot_demo are provided as a Yocto Recipe.
Below are the steps to add fastboot_demo to the Yocto environment and build it.
For details on each step, see [1].

1. From section 4. "Building Instructions on Linux Host PC" in [1]. The following should be done:

    Below is a command example from [1] 4.1 Using build script
    ```bash
    cd ${WORK}
    ./build_yocto.sh whitehawk adas
    ```
    - Note: Select "whitehawk" for `<BOARD>`.
    - Note: Select "adas" for `<CONFIG>`.
    - Note: Leave `<GFX_PATH>` unspecified.

2. Clone repo to ${WORK} folder created in Chapter 4.

3. Add meta-fastboot-poc to your Yocto environment.
    ```bash
    cd ${WORK}
    source poky/oe-init-build-env build-whitehawk-adas
    bitbake-layers add-layer ../meta-fastboot-poc
    ```

4. Build the Yocto environment with meta-fastboot-poc added.
    ```bash
    cd ${WORK}/build-whitehawk-adas
    bitbake rcar-image-adas
    ```

5. That's all
