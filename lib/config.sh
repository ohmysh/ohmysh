#!/bin/bash
# OhMySH Config file reader
# Starts on Augest, 2021 Updates

if [ ! -f "$OMS_CACHE/config.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/etc/config.etc.sh" ]
  then
    cp "$OMS_DIR/lib/etc/config.etc.sh" "$OMS_CACHE/config.ohmysh.sh"
  else
    touch "$OMS_CACHE/config.ohmysh.sh"
  fi
fi

##### GLOBAL SETTINGS #####
# You can not edit the settings below.
export configUpdate='Auto'
export configCover='Enable'
export configStartPath="$HOME/"
export mapLs='Enable'
export mapCd='Enable'
export mapHelp='Enable'
export mapMSDos='Enable'
export mapCSP2021='Disable'
export trashService='Enable'

##### PERSONAL SETTINGS #####
source "$OMS_CACHE/config.ohmysh.sh"
