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

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "\
            file://openbmc-gpio-1/board_gpio_table_v1.py \
			file://openbmc-gpio-1/openbmc_gpio_setup.py \
			file://openbmc-gpio-1/setup_board.py \
			file://openbmc-gpio-1/openbmc_gpio.service \
            "

OPENBMC_GPIO_SOC_TABLE = "ast2500_gpio_table.py"

DEPENDS += "update-rc.d-native"

inherit systemd
SYSTEMD_SERVICE_${PN} = "openbmc_gpio.service"

do_install_append() {
    bin="${D}/usr/local/bin"
    install -d $bin
    install -m 755 openbmc_gpio_setup.py ${bin}/openbmc_gpio_setup.py

    install -d ${D}${systemd_unitdir}/system
    install -m 644 ${WORKDIR}/openbmc-gpio-1/openbmc_gpio.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "/usr/local/bin ${systemd_unitdir}/system "

