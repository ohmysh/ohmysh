#!/bin/bash
#
# Made by OhMySh Dev
# main SH Script
# 

if [ -z "$OMS_DIR" ]
then
  echo " [ERROR 3] OMS settings error !!! "
  exit 3
fi

# Load Config file
source "$OMS_DIR/lib/config.sh"

# Load base script
source "$OMS_DIR/lib/ohmysh-version.sh"
source "$OMS_DIR/lib/logo.sh"
source "$OMS_DIR/lib/color.sh"
source "$OMS_DIR/lib/dir.sh"
source "$OMS_DIR/lib/run-update.sh"
source "$OMS_DIR/lib/update.sh"

# Load functional script
source "$OMS_DIR/lib/check-command.sh"
source "$OMS_DIR/lib/tool/git-prompt.sh"
source "$OMS_DIR/lib/theme.sh"
source "$OMS_DIR/lib/plugin.sh"
source "$OMS_DIR/lib/git.sh"
source "$OMS_DIR/lib/alias.sh"
source "$OMS_DIR/lib/cover.sh"
source "$OMS_DIR/lib/opt/map.sh"

# Load CLI
source "$OMS_DIR/lib/ohmysh-cli.sh"

# RUN THEME
_theme_runner

# RUN PLUGIN
for _p in "${OMS_PLUGIN[@]}"; do
  _plugin_runner "$_p"
done

# RUN Startup Script
source "$OMS_DIR/lib/startup-script.sh"

# RUN Runtime Script
source "$OMS_DIR/lib/runtime-script.sh"
#rm -f "$OMS_CACHE/runtime-script/*.sh"

# Change to Start Path
if [ -n "$configStartPath" ]
then
    cd "$configStartPath"
else
    cd ~
fi
