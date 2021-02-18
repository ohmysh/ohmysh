#!/bin/sh
#
# Made by OhMySh Dev
# main SH Script
# 

if [ -z "$OMS_DIR" ]
then
  echo " >> OMS settings error !!! "
  exit 1
fi

source "$OMS_DIR/lib/ohmysh-version.sh"
source "$OMS_DIR/lib/dir.sh"
source "$OMS_DIR/lib/update.sh"

source "$OMS_DIR/lib/color.sh"
source "$OMS_DIR/lib/theme.sh"
source "$OMS_DIR/lib/plugin.sh"
source "$OMS_DIR/lib/check-command.sh"
source "$OMS_DIR/lib/git.sh"
source "$OMS_DIR/lib/alias.sh"

source "$OMS_DIR/lib/ohmysh-cli.sh"

# RUN THEME
_theme_runner

# RUN PLUGIN
for _p in ${OMS_PLUGIN[@]}; do
  _plugin_runner "$_p"
done

cd ~



