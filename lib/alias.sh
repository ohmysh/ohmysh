if [ ! -f "$OMS_CACHE/alias.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/alias.e.sh" ]
  then
    cp "$OMS_DIR/lib/alias.e.sh" "$OMS_CACHE/alias.ohmysh.sh"
  else
    touch $OMS_CACHE/alias.ohmysh.sh
  fi
fi
source $OMS_CACHE/alias.ohmysh.sh

