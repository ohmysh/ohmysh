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

source $OMS_CACHE/config.ohmysh.sh
