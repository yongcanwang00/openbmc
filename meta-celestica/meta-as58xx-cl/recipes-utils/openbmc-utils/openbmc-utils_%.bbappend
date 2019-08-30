# Copyright 2015-present Facebook. All Rights Reserved.
#
# This program file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the
# Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
      file://disable_watchdog.sh \
      file://boot_info.sh \
      file://create_vlan_intf \
      file://config_bmc_mac.sh \
      file://bmc_mac_config.service \
      file://bmc_wdt.service \
      "

RDEPENDS_${PN} += " python3 bash"
inherit systemd
SYSTEMD_SERVICE_${PN} = "bmc_mac_config.service bmc_wdt.service"

do_install_append() {
    localbindir="/usr/local/bin"
	pkgdir="/usr/local/fbpackages/utils"
    install -d ${D}${localbindir}
	install -d ${D}${pkgdir}
	ln -s "/usr/local/bin/openbmc-utils.sh" "${D}${pkgdir}/ast-functions"
    install -d ${D}${systemd_unitdir}/system


    install -m 0755 ${WORKDIR}/disable_watchdog.sh ${D}${localbindir}/disable_watchdog.sh

    install -m 0755 ${WORKDIR}/config_bmc_mac.sh ${D}${localbindir}/config_bmc_mac.sh

	install -m 0755 boot_info.sh ${D}${localbindir}/boot_info.sh

	# create VLAN intf automatically
    install -d ${D}/${sysconfdir}/network/if-up.d
    install -m 755 create_vlan_intf ${D}${sysconfdir}/network/if-up.d/create_vlan_intf

    install -m 644 ${WORKDIR}/bmc_mac_config.service ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/bmc_wdt.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "${sysconfdir} ${systemd_unitdir}/system"
