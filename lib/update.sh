#!/bin/bash

# OMS UPDATER

if [ -z "$(cat "$OMS_CACHE/update")" ]
then
    date +%Y%m%d > "$OMS_CACHE/update"
fi

_oms_update_channel_fetch(){


    # Checking channel config
    if [ ! -f "$OMS_CACHE/update-channel" ]
    then
        _target="$(cd "$OMS_DIR" && git rev-parse --abbrev-ref HEAD)"
        echo "$_target"> "$OMS_CACHE/update-channel"
    fi
    _es="$(cat "$OMS_CACHE/update-channel")"
    case $_es in
        "main")
            echo "main"
            ;;
        "dev")
            echo "dev"
            ;;
        *)
            echo "main" > "$OMS_CACHE/update-channel"
            echo "main"
            ;;
    esac
}

_oms_update_new(){

    # Checking if have .git/
    [ -d ".git" ] || _error "You are not in a git repository"

    # Creating log file
    _log "OhMySh Update ($(date "+%Y%m%d %H:%M:%S"))" > "$OMS_CACHE/update_fetch.log"
    _log "Update via $(git remote get-url --all origin) ($(git rev-parse --abbrev-ref HEAD))." >> "$OMS_CACHE/update_fetch.log"

    # Fetching update
    git remote update >> "$OMS_CACHE/update_fetch.log" || _error "Cannot get updates" "Updater" '6'

    # Getting branch information
#     UPSTREAM="${1:-'@{u}'}"
#     LOCAL="$(git rev-parse @)"
#     REMOTE="$(git rev-parse "$UPSTREAM")"
#     BASE="$(git merge-base @ "$UPSTREAM")"
    LATEST="$(git describe --abbrev=0 --tags)"
    NOWV="$OMS_VER"

#     if [ $LOCAL = $REMOTE ]; then
#         echo "Up-to-date"
#     elif [ $LOCAL = $BASE ]; then
#         echo "Need to pull"
#     elif [ $REMOTE = $BASE ]; then
#         echo "Need to push"
#     else
#         echo "Diverged"
#     fi

    # Comparing version
    _log "Your current version is $NOWV" >> "$OMS_CACHE/update_fetch.log"
    _log "The latest version is   $LATEST" >> "$OMS_CACHE/update_fetch.log"
    if [ "$LATEST" = "$NOWV" ]
    then
        _log "No update available" >> "$OMS_CACHE/update_fetch.log"
    else
        _log "Updating to version $LATEST..." >> "$OMS_CACHE/update_fetch.log"
        _info "Updating to version $LATEST"
        _oms_update_force
       [ "$(checkcmd "oms_reload")" = "1" ] && oms_reload
    fi
}

_oms_update_force(){
    # Running update
    if [ -d ".git" ]
    then
        if [ "$configUpdate" = "Force" ]
        then
            git checkout "$(_oms_update_channel_fetch)"
            git pull || _error "Cannot get updates" "Updater" '6'
            _info "Forced updated to latest version."
        else
#             git checkout "$LATEST" || _error "Git refused request" "Updater" "6"
            git checkout "$(_oms_update_channel_fetch)"
            git pull
            git checkout "$LATEST"
        fi
        _info "Updated. Press enter to quit."
    else
        _error "You are not in a git repository"
    fi
}

# _oms_update_new

_oms_update(){
    #source $OMS_DIR/lib/ohmysh-version.sh
    _CACHE_VERSION="$OMS_VER"
    _CACHE_BUILD="$OMS_BUILD"
#     _CACHE_CLI_VERSION="$OMS_CLI_VER"
    #_CACHE_CLI_BUILD="$OMS_CLI_BUILD"
    #_CACHE_PLUGIN=(${OMS_PLUGIN[*]})
    cd "$OMS_DIR" || exit

    # Version 2 update
    _oms_update_new

    # Old version update
#     git pull || _error 'ERROR cannot get update!!!' 'Updater' '6'



    source "$OMS_DIR/lib/ohmysh-version.sh"
    date +%Y%m%d > "$OMS_CACHE/update"
    if [ "$_CACHE_VERSION" != "$OMS_VER" ]
    then
        _run_update "$((_CACHE_BUILD+1))" "$OMS_BUILD"
        _info "Updated OhMySH to version $OMS_VER!" 'Updater'
        echo "$_CACHE_VERSION" > "$OMS_CACHE/update-lastver"
        date +%Y%m%d > "$OMS_CACHE/update-lastdate"
    fi
#     if [ "$_CACHE_CLI_VERSION" != "$OMS_CLI_VER" ]
#         then
#         _info "Updated OhMySH CLI to version $OMS_CLI_VER!" 'Updater'
#     fi
}


if [ "$(cat "$OMS_CACHE/update")" != "$(date +%Y%m%d)" ] || [ -n "$forceUpdate" ]
then
    if [ -z "$configUpdateDisable" ] || [ "$configUpdate" != 'Disable' ]
    then
        unset forceUpdate
        _info 'Getting update...' 'Updater'

        # Old version update
#         _oms_update

        # New version update
       _oms_update &


    fi
fi


_oms_update_channel(){
    _rpath="$(pwd)"
    cd "$OMS_DIR" || _error "Unknown Error."
    echo "$1" > "$OMS_CACHE/update-channel"
    git checkout "$1" || _error "The behavior is forbidden by Git."
    cd "$_rpath"
}
