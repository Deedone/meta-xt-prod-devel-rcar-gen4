# we expect to have archive with UM near yaml
FILESEXTRAPATHS:prepend := "${TOPDIR}/../..:"
SRC_URI:r8a779g0 = "file://r8a779g0_linux_gsx_binaries_gles_vz_DDK23.3_v2.tar.bz2"
S = "${WORKDIR}/rogue"

FILES:${PN}:append = " \
    ${libdir}/libsutu_display.so* \
"
