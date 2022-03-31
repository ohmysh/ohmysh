#!/bin/bash

_info "Updating to build_Alpha42..."

if [ -f "$OMS_DIR/lib/opt/profile-update.sh" ]
then
    . "$OMS_DIR/lib/opt/profile-update.sh"
else
    _error "Cannot complete the update."
fi
