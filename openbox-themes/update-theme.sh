#!/bin/bash

set -eEu
set -o pipefail

THEME=$1
GIT_FOLDER='/home/spiffycell/Documents/setup/openbox-themes'

# run the backup
cp ~/.config/openbox/rc.xml ${GIT_FOLDER}/${THEME}/openbox/rc.xml
cp ~/.config/openbox/rc.xml ${GIT_FOLDER}/${THEME}/openbox/rc.xml
cp ~/.config/openbox/autostart ${GIT_FOLDER}/${THEME}/openbox/autostart
cp ~/.config/openbox/environment ${GIT_FOLDER}/${THEME}/openbox/environment
cp ~/.config/tint2/tint2rc ${GIT_FOLDER}/${THEME}/tint2/tint2rc

