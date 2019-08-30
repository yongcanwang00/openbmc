FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
SRC_URI += "file://passwd-util.service \
          "

S = "${WORKDIR}"

inherit systemd
SYSTEMD_SERVICE_${PN} = "passwd-util.service"

do_install() {
  install -d ${D}${bindir}
  install -m 0755 passwd-util ${D}${bindir}/passwd-util

  install -d ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/passwd-util.service ${D}${systemd_unitdir}/system
}

FILES_${PN} = "${prefix}/local/bin ${bindir} ${systemd_unitdir}/system "
