# OhMySH Starting covers
# Starts on June, 2021 Updates

if [ ! -f "$OMS_CACHE/cover.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/etc/cover.etc.sh" ]
  then
    cp "$OMS_DIR/lib/etc/cover.etc.sh" "$OMS_CACHE/cover.ohmysh.sh"
  else
    touch $OMS_CACHE/cover.ohmysh.sh
  fi
fi
source $OMS_CACHE/cover.ohmysh.sh
