FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://0001-xen_rproc-add-initial-version-of-Xen-rproc-driver.patch \
    file://0002-xen_rproc-add-support-for-Xen-based-rproc-management.patch \
    file://0003-rproc-try-to-acquire-reserved-DMA-region.patch \
    file://0004-rproc-Attach-device-instead-of-starting.patch \
    file://0005-remoteproc-inherit-dma_coherent-flag-from-parent-dev.patch \
    file://rproc.cfg \
"
