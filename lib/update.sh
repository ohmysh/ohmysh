#!/bin/sh

# OMS UPDATER

if [ -z $(cat $OMS_CACHE/update) ]
then
    echo $(date +%Y%m%d > $OMS_CACHE/update)
fi

if [ $(cat $OMS_CACHE/update) != $(date +%Y%m%d) ] || [ ! -z $forceUpdate ]
then
    if [ -z "$configUpdateDisable" ] || [ "$configUpdate" != 'Disable' ]
    then
        _info 'Getting update...' 'Updater'
        #source $OMS_DIR/lib/ohmysh-version.sh
        _CACHE_VERSION="$OMS_VER"
        _CACHE_BUILD="$OMS_BUILD"
        _CACHE_CLI_VERSION="$OMS_CLI_VER"
        _CACHE_CLI_BUILD="$OMS_CLI_BUILD"
        _CACHE_PLUGIN=(${OMS_PLUGIN[*]})
        cd $OMS_DIR
        git pull || _error 'ERROR cannot get update!!!' 'Updater' '7'
        source $OMS_DIR/lib/ohmysh-version.sh
        date +%Y%m%d > $OMS_CACHE/update
        if [ "$_CACHE_VERSION" != "$OMS_VER" ]
        then
            _run_update $(expr $_CACHE_BUILD + 1) $OMS_BUILD
            _info 'Updated OhMySH to version $OMS_VER!' 'Updater'
            echo "$_CACHE_VERSION" > $OMS_CACHE/update-lastver
            date +%Y%m%d > $OMS_CACHE/update-lastdate
        fi
        if [ "$_CACHE_CLI_VERSION" != "$OMS_CLI_VER" ]
            then
            _info 'Updated OhMySH CLI to version $OMS_CLI_VER!' 'Updater'
        fi
    fi
fi
