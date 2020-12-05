#!/bin/sh

# OMS UPDATER

if [ $(cat $OMS_CACHE/update) != $(date +%Y%m%d) ]
then
  echo " OhMySh::Updater : Getting update... "
  cd $OMS_DIR
  git pull || echo " OhMySh::Updater : ERROR cannot get update!!! "
  date +%Y%m%d > $OMS_CACHE/update
fi
