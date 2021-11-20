#!/bin/bash
# OhMySH Starting covers
# Starts in June 2021 Updates; Updated in October 2021.

if [ ! -f "$OMS_CACHE/cover.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/etc/cover.etc.sh" ]
  then
    cp "$OMS_DIR/lib/etc/cover.etc.sh" "$OMS_CACHE/cover.ohmysh.sh"
  else
    touch $OMS_CACHE/cover.ohmysh.sh
  fi
fi

if [ "$OMS_COVER" != "NONE" ] && [ -z "$configCoverDisable" ] && [ "$configCover" != "Disable" ]
then
  source $OMS_CACHE/cover.ohmysh.sh
fi

