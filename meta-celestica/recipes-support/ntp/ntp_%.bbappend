FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://ntp.conf \
            file://ntpd.service \
           "

inherit systemd
SYSTEMD_SERVICE_${PN} = "ntpd.service"

do_install_append() {
  install -d ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/ntpd.service ${D}${systemd_unitdir}/system
}
FILES_${PN} += "${systemd_unitdir}/system"
