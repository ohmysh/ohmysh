#!/bin/sh

# OMS UPDATER

if [ -z $(cat $OMS_CACHE/update) ]
then
  echo $(date +%Y%m%d > $OMS_CACHE/update)
fi

if [ $(cat $OMS_CACHE/update) != $(date +%Y%m%d) ] || [ ! -z $forceUpdate ]
then
  echo " OhMySh::Updater : Getting update... "
  source $OMS_DIR/lib/ohmysh-version.sh
  _CACHE_VERSION=$OMS_VER
  cd $OMS_DIR
  git pull || echo " OhMySh::Updater : ERROR cannot get update!!! "
  source $OMS_DIR/lib/ohmysh-version.sh
  date +%Y%m%d > $OMS_CACHE/update
  if [ "$_CACHE_VERSION" != "$OMS_VER" ]
  then
    echo " OhMySh::Updater : Updated to OhMySh version $OMS_VER"
  fi
fi
