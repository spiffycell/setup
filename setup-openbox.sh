#!/bin/bash

THEME=$1
WORKDIR="./$THEME/"
LOCAL="~/.config/"

cp ${WORKDIR}/openbox/rc.xml ${LOCAL}/openbox/rc.xml 
cp ${WORKDIR}/openbox/menu.xml ${LOCAL}/openbox/menu.xml 
cp ${WORKDIR}/openbox/autostart ${LOCAL}/openbox/autostart
cp ${WORKDIR}/environment ${LOCAL}/openbox/environment
cp ${WORKDIR}/tint2/tint2rc ${LOCAL}/tint2/tint2rc

