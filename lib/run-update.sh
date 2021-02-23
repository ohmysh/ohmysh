#!/bin/bash

# OhMySH Update in here

# upd OLD NEW

_run_update(){
    _s="$1"
    _e="$2"
    for((i=$_s;i<=$_e;i++));
    do
        if [ -f "$OMS_DIR/lib/opt/update/oms-build-$i.sh" ]
        then
            _info "Building OhMySH version build_$i..." 'Updater'
            . "$OMS_DIR/lib/opt/update/oms-build-$i.sh"
        fi
    done
}


