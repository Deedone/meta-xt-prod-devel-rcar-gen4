# This is HACK to fix systemd build due to difference of this patch on different yocto
SRC_URI:remove:rcar-v4x = " file://add-non-owned-item-for-safe-transitioning.patch"
