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
# You should have received a copy of the GNU General Public License
# along with this program in a file named COPYING; if not, write to the
# Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301 USA

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += "file://mTerm.service \
            file://sol.sh \
			file://tty_helper.h \
			file://mTerm_helper.h \
			file://mTerm_helper.c \
           "

S = "${WORKDIR}"
CONS_BIN_FILES += "sol.sh \
                  "
inherit systemd
SYSTEMD_SERVICE_${PN} = "mTerm.service"

# Go with default names of mTerm for MTERM_SERVICES
# since we have just one console.

do_install() {
  dst="${D}/usr/local/fbpackages/${pkgdir}"
  bin="${D}/usr/local/bin"
  install -d $dst
  install -d $bin
  for f in ${CONS_BIN_FILES}; do
     install -m 755 $f ${dst}/$f
     ln -snf ../fbpackages/${pkgdir}/$f ${bin}/$f
  done

  install -d ${D}${systemd_unitdir}/system
  install -m 644 ${WORKDIR}/mTerm.service ${D}${systemd_unitdir}/system
}

FILES_${PN} += "/usr/local/bin ${systemd_unitdir}/system "
