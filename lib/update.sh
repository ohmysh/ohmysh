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
    # Debug
    [ -n "$_DEBUG_UPDATE" ] && _debug "Cought flag UPDATE."

    # Checking if have .git/
    [ -d ".git" ] || _error "You are not in a git repository"

    # Creating log file
    _log "OhMySh Update ($(date "+%Y%m%d %H:%M:%S"))" > "$OMS_CACHE/update_fetch.log"
    [ -n "$_DEBUG_UPDATE" ] && _debug "OhMySh Update ($(date "+%Y%m%d %H:%M:%S"))"
    _log "Update via $(git remote get-url --all origin) ($(git rev-parse --abbrev-ref HEAD))." >> "$OMS_CACHE/update_fetch.log"
    [ -n "$_DEBUG_UPDATE" ] && _debug "Update via $(git remote get-url --all origin) ($(git rev-parse --abbrev-ref HEAD))."

    # Fetching update
    git remote update > "$OMS_CACHE/update_remote_fetch.log" || _error "Cannot get updates" "Updater" '6'

    [ -n "$_DEBUG_UPDATE" ] && cat "$OMS_CACHE/update_remote_fetch.log"
    cat "$OMS_CACHE/update_remote_fetch.log" >> "$OMS_CACHE/update_fetch.log"

    # Getting branch information
#     UPSTREAM="${1:-'@{u}'}"
#     LOCAL="$(git rev-parse @)"
#     REMOTE="$(git rev-parse "$UPSTREAM")"
#     BASE="$(git merge-base @ "$UPSTREAM")"
    
    # LATEST="$(git describe --abbrev=0 --tags)"
    NOWV="$OMS_VER"

    # Get new version from main/dev branch.
    BRCH="$(_oms_update_channel_fetch)"
    [ -n "$_DEBUG_UPDATE" ] && _debug "Checking out to branch $BRCH to get the latest version."
    git checkout "$BRCH" &> /dev/null
    git pull > "$OMS_CACHE/update_remote_fetch.log" || _error "Cannot get updates" "Updater" '6'
    . "$OMS_DIR/lib/ohmysh-version.sh"
    LATEST="$OMS_VER"

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
    [ -n "$_DEBUG_UPDATE" ] && _debug "Your current version is $NOWV"
    _log "The latest version is   $LATEST" >> "$OMS_CACHE/update_fetch.log"
    [ -n "$_DEBUG_UPDATE" ] && _debug "The latest version is   $LATEST"

    if [ "$LATEST" = "$NOWV" ]
    then
        _log "No update available." >> "$OMS_CACHE/update_fetch.log"
        [ -n "$_DEBUG_UPDATE" ] && _debug "No update available."
        git checkout "$NOWV" &> /dev/null
    else
        _log "Updating to version $LATEST..." >> "$OMS_CACHE/update_fetch.log"
        _info "Updating to version $LATEST"
        [ -n "$_DEBUG_UPDATE" ] && _debug "Starting update..."
        _oms_update_force
        [ -n "$_DEBUG_UPDATE" ] && _debug "Updated.  Reloading..."
        [ "$(checkcmd "oms_reload")" = "1" ] && oms_reload
        [ -n "$_DEBUG_UPDATE" ] && _debug "Reloaded. Updating debug finished."
    fi
}

_oms_update_force(){
    # Running update
    if [ -d ".git" ]
    then
        if [ "$configUpdate" = "Force" ]
        then
            [ -n "$_DEBUG_UPDATE" ] && _debug "Force updating to the branch latest commit..."
            # [ -n "$_DEBUG_UPDATE" ] && _debug "Checkout."
            # git checkout "$(_oms_update_channel_fetch)"
            [ -n "$_DEBUG_UPDATE" ] && _debug "Pull."
            git pull || _error "Cannot get updates" "Updater" '6'
            _info "Forced updated to latest version."
        else
#             git checkout "$LATEST" || _error "Git refused request" "Updater" "6"
            [ -n "$_DEBUG_UPDATE" ] && _debug "Updating to the latest tag..."
            # [ -n "$_DEBUG_UPDATE" ] && _debug "Checkout."
            # git checkout "$(_oms_update_channel_fetch)"
            [ -n "$_DEBUG_UPDATE" ] && _debug "Pull."
            git pull
            [ -n "$_DEBUG_UPDATE" ] && _debug "Checkout."
            git checkout "$LATEST" &> /dev/null
            [ -n "$_DEBUG_UPDATE" ] && _debug "Done."
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
        _lolout "Updated OhMySH to version $OMS_VER!" 'Updater'
        echo "$_CACHE_VERSION" > "$OMS_CACHE/update-lastver"
        date +%Y%m%d > "$OMS_CACHE/update-lastdate"
    fi
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
