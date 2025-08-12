FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://0001-mount-Allow-building-when-macro-MOUNT_ATTR_IDMAP-is-.patch \
            file://0002-mount-Allow-building-when-macro-LOOP_CONFIGURE-is-no.patch \
            "

PACKAGECONFIG:append = " curl libarchive builtin-grub2-mkconfig"
PACKAGECONFIG:class-native:append = " curl"
# gpgme is not required by us, and it brings GPLv3 dependencies
PACKAGECONFIG:remove = "gpgme"
PACKAGECONFIG:remove = "${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '', 'soup', d)}"

# Build ostree with composefs support only if DISTRO_FEATURES "cfs" is set.
PACKAGECONFIG:append = "${@bb.utils.contains('DISTRO_FEATURES', 'cfs', ' composefs', '', d)}"
PACKAGECONFIG:append:class-native = "${@bb.utils.contains('DISTRO_FEATURES', 'cfs', ' composefs', '', d)}"

# Ensure ed25519 is available for signing commits.
PACKAGECONFIG:append = "${@bb.utils.contains('DISTRO_FEATURES', 'cfs-signed', ' ed25519-libsodium', '', d)}"
PACKAGECONFIG:append:class-native = "${@bb.utils.contains('DISTRO_FEATURES', 'cfs-signed', ' ed25519-libsodium', '', d)}"

# TODO: Upstream this addition.
PACKAGECONFIG[composefs] = "--with-composefs, --without-composefs"
