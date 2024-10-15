FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SUPPORT_RVGC = " \
    file://0001-Added-rgvc-driver.patch \
    file://0002-renamed-driver-to-rcar-du.patch \
    file://0003-Add-support-for-multiple-drm-layers.patch \
    file://0004-rvgc-Fix-display-index-passed-to-rvgc_taurus_display.patch \
    file://0005-rvgc-If-layer-size-not-specified-use-the-display-siz.patch \
    file://0006-Added-the-mfis-driver.patch \
    file://0007-public-header-for-the-mfis-client.patch \
    file://0008-Added-virtual-can-driver-over-taurus.patch \
    file://0009-Added-remoteproc-module.patch \
    file://0010-remoteproc-add-support-for-co-processor-loaded-and-b.patch \
    file://0011-remoteproc-rcar-If-the-CR7-FW-is-already-running-lea.patch \
    file://0012-Added-taurus-sample-client-not-tested-on-e3.patch \
    file://0013-Added-patch-for-virtio.patch \
    file://0014-arm64-dts-Add-Ebisu-4d-cr7_rproc.patch \
    file://0015-arm64-dts-Ebisu-cr7-Undo-increase-in-cma-add-comment.patch \
    file://0016-arm64-dts-Ebisu-cr7-Reserve-memory-for-CR7-operation.patch \
    file://0017-arm64-dts-Add-Salvator-XS-cr7_rproc.patch \
    file://0018-arm64-dts-renesas-ebisu-4d_cr7_rproc-Add-multiple-DR.patch \
    file://0019-arm64-dts-Change-E3-RVGC-layer-size-and-position.patch \
    file://0020-rcar-taurus-Fix-compiler-warning.patch \
    file://0021-rcar-mfis-Change-to-use-ioremap-from-ioremap_nocache.patch \
    file://0022-remoteproc-rcar-Fix-the-recursive-dependency-error.patch \
    file://0023-remoteproc-rcar-Change-to-use-ioremap-from-ioremap_n.patch \
    file://0024-remoteproc-rcar-Fix-compiler-warnings.patch \
    file://0025-arm64-dts-renesas-r8a77961-Amend-soc-device-group.patch \
    file://0026-drm-rcar-rvgc-Remove-drm_fbdev_cma-functions.patch \
    file://0027-drm-rcar-rvgc-Add-lacking-header-file.patch \
    file://0028-drm-rcar-rvgc-Remove-DRIVER_PRIME-feature.patch \
    file://0029-drm-rcar-rvgc-Replace-drm_dev_unref-with-drm_dev_put.patch \
    file://0030-drm-rcar-rvgc-Use-drm_gem_fb_create.patch \
    file://0031-drm-rcar-rvgc-Add-lacked-header-files.patch \
    file://0032-drm-rcar-rvgc-Let-drm-core-handle-connector.patch \
    file://0033-drm-rcar-rvgc-drop-_mode_-from-drm_mode_connector_at.patch \
    file://0034-drm-rcar-rvgc-Switch-to-drm_gem_fb_prepare_fb.patch \
    file://0035-rcar-soc-Remove-Cortex-R7-power-domain.patch \
    file://0036-Enable-configs-from-cr7_virt.cfg.patch \
    file://0037-Fix-building-warning.patch \
    file://0038-remoteproc-use-dynamic-allocation-if-bad-carveout-rs.patch \
    file://0039-drm-rcar-rvgc-set-the-lacking-DMA-mask.patch \
    file://0040-media-Add-virtual-video-device-rcar-vivid.patch \
    file://0041-arm64-defconfig-Add-Para-VIN-driver-configuration.patch \
    file://0043-drm-rcar-rvgc-Fix-build-warnings.patch \
    file://0044-can-rcar-taurus-Fix-build-warning.patch \
    file://0045-rproc-rcar_rcr7_remoteproc-Fix-build-warnings.patch \
    file://0046-arm64-dts-renesas-Add-r8a779m1-Salvator-XS-cr7_rproc.patch \
    file://0047-arm64-dts-salvator-xs-cr7_rproc-multi-layer-sample.patch \
    file://0048-driver-net-can-rcar-taurus-Update-license-to-Dual-MI.patch \
    file://0049-driver-gpu-drm-rcar-rvgc-Update-license-to-Dual-MIT-.patch \
    file://0050-driver-media-platform-rcar-vivid-Update-license-to-D.patch \
    file://0051-driver-misc-rcar-mfis-Update-license-to-Dual-MIT-GPL.patch \
    file://0054-arm64-dts-salvator-xs-cr7_rproc-Add-device-node-for-.patch \
    file://0055-arch-arm64-dts-salvator-xs-cr7_rproc-Disable-RT-DMAC.patch \
    file://0064-drivers-media-platform-rcar-vivid-Adding-coherent_dm.patch \
    file://0065-drivers-media-platform-rcar-vivid-rcar-vivid-v4l2-Up.patch \
    file://0066-arm64-dts-salvator-xs-cr7_rproc-Add-layer-for-overla.patch \
    file://0067-media-platform-rcar-vivid-rcar-vivid-v4l2-Release-ch.patch \
    file://0068-net-can-rcar-taurus-Add-fixes-to-support-CAN-FD.patch \
    file://0069-clk-renesas-r8a7795-Disable-CAN-FD-core-clock.patch \
    file://paradriver.cfg \
    file://add_cr52.patch \
    file://cr52.cfg \
    file://0001-device-tree-renesas-cr52_rproc-Change-display-map-fr.patch \
    file://0001-drm-rcar_rvgc-Fix-flip_done-timeout-when-diabling-cr.patch \
    file://0002-device-tree-renesas-cr52_rproc-Enable-use-of-cameras.patch \
    file://0001-device-tree-renesas-cr52_rproc-Enable-pcie.patch \
    file://0002-drm-rcar_rvgc-Fix-plane-reserve-to-set-fb.patch \
"

SRC_URI:append = " \
    ${SUPPORT_RVGC} \
"
