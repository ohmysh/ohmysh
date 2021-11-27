#!/bin/bash

if [ ! -f "$OMS_CACHE/alias.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/etc/alias.etc.sh" ]
  then
    cp "$OMS_DIR/lib/etc/alias.etc.sh" "$OMS_CACHE/alias.ohmysh.sh"
  else
    touch "$OMS_CACHE/alias.ohmysh.sh"
  fi
fi
source "$OMS_CACHE/alias.ohmysh.sh"

