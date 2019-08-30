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
    file://rest-api-1/rest.py \
    file://rest-api-1/rest_bmc.py \
    file://rest-api-1/rest_fruid.py \
    file://rest-api-1/rest_led.py \
    file://rest-api-1/rest_sensors.py \
    file://rest-api-1/rest_eth.py \
    file://rest-api-1/rest_raw.py \
    file://rest-api-1/rest_temp.py \
    file://rest-api-1/rest_syslog.py \
    file://rest-api-1/rest_watchdog.py \
    file://rest-api-1/rest_userpassword.py \
    file://rest-api-1/rest_upgrade.py \
    file://board_endpoint.py \
    file://boardroutes.py \
    file://board_setup_routes.py \
    file://common_endpoint.py \
    file://common_setup_routes.py \
    file://rest_utils.py \
    file://restful.service \
    "

binfiles1 += " \
    rest.py \
    rest_bmc.py \
    rest_fruid.py \
    rest_led.py \
    rest_sensors.py \
    rest_eth.py \
    rest_raw.py \
    rest_temp.py \
    rest_syslog.py \
    rest_watchdog.py \
    rest_userpassword.py \
    rest_upgrade.py \
    "

binfiles += " \
    board_endpoint.py \
    board_setup_routes.py \
    boardroutes.py \
    common_endpoint.py \
    common_setup_routes.py \
    rest_utils.py \
    "

inherit systemd
SYSTEMD_SERVICE_${PN} = "restful.service"

do_install_append() {
  dst="${D}/usr/local/fbpackages/${pkgdir}"
  bin="${D}/usr/local/bin"
  install -d $dst
  install -d $bin
  for f in ${binfiles1}; do
    install -m 755 $f ${dst}/$f
    ln -snf ../fbpackages/${pkgdir}/$f ${bin}/$f
  done
  for f in ${binfiles}; do
    install -m 755 ${WORKDIR}/$f ${dst}/$f
    ln -snf ../fbpackages/${pkgdir}/$f ${bin}/$f
  done
  for f in ${otherfiles}; do
    install -m 644 $f ${dst}/$f
  done
  install -m 644 ${WORKDIR}/rest.cfg ${D}${sysconfdir}/rest.cfg

  install -d ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/restful.service ${D}${systemd_unitdir}/system
}

FBPACKAGEDIR = "${prefix}/local/fbpackages"

FILES_${PN} = "${FBPACKAGEDIR}/rest-api ${prefix}/local/bin ${sysconfdir} ${systemd_unitdir}/system"

