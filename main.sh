#!/bin/sh
#
# Made by OhMySh Dev
# main SH Script
# 

if [ "$OMS_DIR" == "" ]
then
  echo " >> OMS settings error !!! "
  exit 1
fi

source "$OMS_DIR/lib/ohmysh-version.sh"
source "$OMS_DIR/lib/dir.sh"
source "$OMS_DIR/lib/update.sh"

source "$OMS_DIR/lib/color.sh"
source "$OMS_DIR/lib/theme.sh"
source "$OMS_DIR/lib/check-command.sh"
source "$OMS_DIR/lib/git.sh"

source "$OMS_DIR/lib/ohmysh-cli.sh"

# RUN THEME
_theme_runner

# RUN PLUGIN
for plug in ${OMS_PLUGIN[@]}; do
  source "$OMS_DIR/usr/plugin/$plug/$plug.plugin.sh"
done

