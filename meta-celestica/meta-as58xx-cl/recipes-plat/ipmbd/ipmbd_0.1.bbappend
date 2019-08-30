# Copyright 2015-present Facebook. All Rights Reserved.

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += " file://ipmbd.service \
           "
#DEPENDS_append = " platform-lib "

CFLAGS_prepend = " -DCONFIG_FBTTN"
inherit systemd
SYSTEMD_SERVICE_${PN} = "ipmbd.service"

do_install() {
  dst="${D}/usr/local/fbpackages/${pkgdir}"
  bin="${D}/usr/local/bin"
  install -d $dst
  install -d $bin
  install -m 755 ipmbd ${dst}/ipmbd
  ln -snf ../fbpackages/${pkgdir}/ipmbd ${bin}/ipmbd

  install -d ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/ipmbd.service ${D}${systemd_unitdir}/system
}

FBPACKAGEDIR = "${prefix}/local/fbpackages"

FILES_${PN} = "${FBPACKAGEDIR}/ipmbd ${prefix}/local/bin ${systemd_unitdir}/system "

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INHIBIT_PACKAGE_STRIP = "1"
