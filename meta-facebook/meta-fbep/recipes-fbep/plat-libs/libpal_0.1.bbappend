FILESEXTRAPATHS_prepend := "${THISDIR}/files/pal:"

SRC_URI += "file://pal.c \
            file://pal.h \
            file://pal_sensors.c \
            file://pal_sensors.h \
            "

SOURCES += "pal_sensors.c"
HEADERS += "pal_sensors.h"
DEPENDS += ""
RDEPENDS_${PN} += ""
LDFLAGS += ""
