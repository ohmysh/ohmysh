#!/bin/bash

# OhMySH Update in here

# upd OLD NEW

_run_update(){
    _s="$1"
    _e="$2"
    [ -n "$_DEBUG_UPDATERUN" ] && _debug "Start from $_s ." "Update.runner"
    [ -n "$_DEBUG_UPDATERUN" ] && _debug "End at $_e ." "Update.runner"
    for ((i=_s;i<=_e;i++))
    do
        if [ -f "$OMS_DIR/lib/opt/update/oms-build-$i.sh" ]
        then
            _info "Building OhMySH version build_$i..." 'Update.runner'
            [ -n "$_DEBUG_UPDATERUN" ] && cat "$OMS_DIR/lib/opt/update/oms-build-$i.sh"
            [ -n "$_DEBUG_UPDATERUN" ] && echo " ----------------------------- "
            . "$OMS_DIR/lib/opt/update/oms-build-$i.sh"
        fi
    done
    [ -n "$_DEBUG_UPDATERUN" ] && _debug "Finished." "Update.runner"
}


