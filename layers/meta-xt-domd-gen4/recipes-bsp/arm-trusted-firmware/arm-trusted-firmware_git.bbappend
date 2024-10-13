FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:remove:rcar-v4x = " file://0001-Makefile-Disable-linker-warning.patch"
SRC_URI:append:rcar-v4x = " file://0001-HACK-v4h-Configure-IPMMU-registers.patch"
SRC_URI:remove:r8a779g0 = " file://0002-HACK-s4-Configure-IPMMU-registers.patch"
