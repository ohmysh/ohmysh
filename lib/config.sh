# OhMySH Config file reader
# Starts on Augest, 2021 Updates

if [ ! -f "$OMS_CACHE/config.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/etc/config.etc.sh" ]
  then
    cp "$OMS_DIR/lib/etc/config.etc.sh" "$OMS_CACHE/config.ohmysh.sh"
  else
    touch $OMS_CACHE/config.ohmysh.sh
  fi
fi

##### GLOBAL SETTINGS #####
# You can not edit the settings below.
configUpdate='Auto'
configCover='Enable'
configStartPath="$HOME/"
mapLs='Enable'
mapCd='Enable'
mapHelp='Enable'
mapMSDos='Enable'
mapCSP2021='Enable'

##### PERSONAL SETTINGS #####
source $OMS_CACHE/config.ohmysh.sh
