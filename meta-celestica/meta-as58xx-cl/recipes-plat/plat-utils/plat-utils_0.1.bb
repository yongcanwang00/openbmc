# Copyright 2014-present Facebook. All Rights Reserved.
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
# You should have received a copy of the GNU General Public License
# along with this program in a file named COPYING; if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301 USA
SUMMARY = "Utilities"
DESCRIPTION = "Various utilities"
SECTION = "base"
PR = "r1"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=eb723b61539feef013de476e68b5c50a"

SRC_URI = "file://ast-functions \
           file://setup_i2c_fishbone.sh \
           file://setup_i2c_phalanx.sh \
           file://setup_pca9506.sh \
           file://setup_isl68137.sh \
           file://rsyslog_config.sh \
           file://wedge_power.sh \
           file://board-utils.sh \
           file://power-on.sh \
           file://bcm5387.sh \
           file://setup_platform.sh \
           file://setup_sensors_fishbone.sh \
           file://setup_sensors_phalanx.sh \
           file://power_monitor_fishbone.py \
           file://power_monitor_phalanx.py \
           file://fru-util \
           file://come_power.sh \
           file://mount_emmc.sh \
           file://us_monitor.sh \
           file://start_us_monitor.sh \
           file://version_dump \
           file://led_location.sh \
           file://rc.local \
           file://power \
           file://led_location \
           file://power_monitor.sh \
           file://platform.service \
           file://us_monitor.service \
           file://power-on.service \
           file://mount_emmc.service \
           file://power_monitor.service \
           file://COPYING \
          "

pkgdir = "utils"

S = "${WORKDIR}"

binfiles = " \
  "

inherit systemd

SYSTEMD_SERVICE_${PN} = "platform.service us_monitor.service power-on.service mount_emmc.service power_monitor.service"


do_install() {
  dst="${D}/usr/local/fbpackages/${pkgdir}"
  localbindir="/usr/local/bin"
  install -d ${D}${localbindir}
  install -d $dst
  install -m 644 ast-functions ${dst}/ast-functions

  # init
  install -d ${D}${sysconfdir}/init.d
  install -d ${D}/mnt
  install -d ${D}${systemd_unitdir}/system

  install -m 0755 bcm5387.sh ${D}${localbindir}/bcm5387.sh
  install -m 0755 wedge_power.sh ${D}${localbindir}/wedge_power.sh
  install -m 0755 board-utils.sh ${D}${localbindir}/board-utils.sh
  install -m 755 setup_pca9506.sh ${D}${localbindir}/setup_pca9506.sh
  install -m 755 setup_isl68137.sh ${D}${localbindir}/setup_isl68137.sh
  install -m 755 power_monitor_fishbone.py ${D}${localbindir}/power_monitor_fishbone.py
  install -m 755 power_monitor_phalanx.py ${D}${localbindir}/power_monitor_phalanx.py

  install -m 0755 rc.local ${D}/mnt/rc.local
  
  install -m 755 setup_i2c_fishbone.sh ${D}${localbindir}/setup_i2c_fishbone.sh
  install -m 755 setup_i2c_phalanx.sh ${D}${localbindir}/setup_i2c_phalanx.sh

  #mount EMMC
  install -m 755 mount_emmc.sh ${D}${localbindir}/mount_emmc.sh

  install -m 755 us_monitor.sh ${D}${localbindir}/us_monitor.sh
  install -m 755 start_us_monitor.sh ${D}${localbindir}/start_us_monitor.sh

  install -m 755 power-on.sh ${D}${localbindir}/power-on.sh

  install -m 755 setup_sensors_fishbone.sh ${D}${localbindir}/setup_sensors_fishbone.sh
  install -m 755 setup_sensors_phalanx.sh ${D}${localbindir}/setup_sensors_phalanx.sh
  install -m 755 setup_platform.sh ${D}${localbindir}/setup_platform.sh

  install -m 0755 fru-util ${D}${localbindir}/fru-util
  install -m 755 come_power.sh ${D}${localbindir}/come_power.sh
  install -m 755 version_dump ${D}${localbindir}/version_dump
  install -m 755 led_location.sh ${D}${localbindir}/led_location.sh
  install -m 755 power ${D}${localbindir}/power
  install -m 755 led_location ${D}${localbindir}/led_location
  install -m 755 power_monitor.sh ${D}${localbindir}/power_monitor.sh

  install -m 644 ${WORKDIR}/platform.service ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/us_monitor.service ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/power-on.service ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/mount_emmc.service ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/power_monitor.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "/usr/local /mnt ${sysconfdir} ${systemd_unitdir}/system"

RDEPENDS_${PN} = "bash"
