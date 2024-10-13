FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://v2-0001-rcar-create-rcar3-platform-file.patch \
    file://v2-0002-arm-platform-add-late_init-callback.patch \
    file://v2-0003-rcar3-add-support-for-MFIS-driver.patch \
    file://v2-0004-rcar3-add-pv-rproc-support.patch \
    file://v2-0005-xen-arm-introduce-p2m_is_mmio.patch \
    file://v2-0006-xen-add-a-p2mt-parameter-to-map_mmio_regions.patch \
    file://v2-0007-xen-extend-XEN_DOMCTL_memory_mapping-to-handle-me.patch \
    file://v2-0008-libxc-introduce-xc_domain_mem_map_policy.patch \
    file://v2-0009-libxl-xl-add-memory-policy-option-to-iomem.patch \
    file://v2-0010-xen-arm-clarify-the-support-status-of-iomem-confi.patch \
    file://v2-0011-domctl-add-enable_rproc-domctl.patch \
    file://v2-0012-platform-add-ability-to-provide-platform-specific.patch \
    file://v2-0013-rcar3-move-MFIS-SPI-IRQ-number-definition-to-publ.patch \
    file://v2-0014-rcar3-add-domctl-handler.patch \
    file://v2-0015-tools-xc-add-xc_domain_setrproc-function.patch \
    file://v2-0016-tools-xl-add-rproc-option.patch \
    file://v2-0017-rcar3-do-not-enable-MFIS-and-rproc-for-Dom0.patch \
    file://v2-0018-xen-arm-Introduce-platform_domain_destroy-and-cor.patch \
    file://v2-0019-xsm-add-Flask-policy-for-enable_rproc.patch \
    file://v2-0020-destroy_domain-add-verification-of-NULL-to-avoid-.patch \
    file://v2-0021-drivers-add-MISC_DEVICE-support.patch \
    file://v2-0022-rproc-move-rproc-code-to-separate-driver-enable-f.patch \
    file://v2-0023-rcar3-delete-rcar3-specific-code.patch \
"
