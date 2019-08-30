
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://interfaces \
            file://setup-dhc6.sh \
            file://networking.service \
"
inherit systemd
SYSTEMD_SERVICE_${PN} = "networking.service"

do_install_append() {
#  install -d ${D}${sysconfdir}/init.d \
#          ${D}${sysconfdir}/network/if-pre-up.d \
#          ${D}${sysconfdir}/network/if-up.d \
#          ${D}${sysconfdir}/network/if-down.d \
#          ${D}${sysconfdir}/network/if-post-down.d
#  install -m 0755 ${WORKDIR}/init ${D}${sysconfdir}/init.d/networking
#  install -m 0644 ${WORKDIR}/interfaces ${D}${sysconfdir}/network/interfaces
#  install -m 0755 ${WORKDIR}/nfsroot ${D}${sysconfdir}/network/if-pre-up.d

  install -d ${D}${systemd_unitdir}/system
  install -d "${D}/etc/systemd/system"
  install -m 644 ${WORKDIR}/networking.service ${D}${systemd_unitdir}/system
  ln -s ${systemd_unitdir}/system/networking.service ${D}/etc/systemd/system/networking.service
}
FILES_${PN} += "${systemd_unitdir}/system"
