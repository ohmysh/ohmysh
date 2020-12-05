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

source "$OMS_DIR/lib/update.sh"

source "$OMS_DIR/lib/color.sh"
source "$OMS_DIR/lib/theme.sh"
source "$OMS_DIR/lib/check-command.sh"
source "$OMS_DIR/lib/git.sh"

# RUN THEME
source "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"
PS1="\[$(tput sc; rightprompt $OMS_THEME_RIGHT; tput rc)\]$OMS_THEME_PS"

# RUN PLUGIN
for plug in ${OMS_PLUGIN[@]}; do
  source "$OMS_DIR/usr/plugin/$plug/$plug.plugin.sh"
done

