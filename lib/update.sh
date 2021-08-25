#!/bin/sh

# OMS UPDATER

if [ -z $(cat $OMS_CACHE/update) ]
then
    echo $(date +%Y%m%d > $OMS_CACHE/update)
fi

if [ $(cat $OMS_CACHE/update) != $(date +%Y%m%d) ] || [ ! -z $forceUpdate ]
then
    if [ -z "$configUpdateDisable" ]
    then
        echo " OhMySh::Updater : Getting update... "
        #source $OMS_DIR/lib/ohmysh-version.sh
        _CACHE_VERSION="$OMS_VER"
        _CACHE_BUILD="$OMS_BUILD"
        _CACHE_CLI_VERSION="$OMS_CLI_VER"
        _CACHE_CLI_BUILD="$OMS_CLI_BUILD"
        _CACHE_PLUGIN=(${OMS_PLUGIN[*]})
        cd $OMS_DIR
        git pull || echo " OhMySh::Updater : ERROR cannot get update!!! "
        source $OMS_DIR/lib/ohmysh-version.sh
        date +%Y%m%d > $OMS_CACHE/update
        if [ "$_CACHE_VERSION" != "$OMS_VER" ]
        then
            _run_update $(expr $_CACHE_BUILD + 1) $OMS_BUILD
            echo " OhMySh::Updater : Updated OhMySH to version $OMS_VER!"
            echo "$_CACHE_VERSION" > $OMS_CACHE/update-lastver
            date +%Y%m%d > $OMS_CACHE/update-lastdate
        fi
        if [ "$_CACHE_CLI_VERSION" != "$OMS_CLI_VER" ]
            then
            echo " OhMySh::Updater : Updated OhMySH CLI to version $OMS_CLI_VER!"
        fi
    fi
fi
