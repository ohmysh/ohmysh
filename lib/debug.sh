#!/bin/bash

# Rule: _DEBUG_XXXXXX
# @FAQ: ERROR 13

declare -A _OMS_DEBUG_LIST
_OMS_DEBUG_LIST[update]='UPDATE'

export _OMS_DEBUG_LIST

_debug_check(){
    if [ -n '$'"_DEBUG_${_OMS_DEBUG_LIST[${1}]}" ] && [ "$(eval echo '$'"_DEBUG_${_OMS_DEBUG_LIST[${1}]}")" = "DEBUG" ]
    then
        _info "Element \"$1\" (\"_DEBUG_${_OMS_DEBUG_LIST[${1}]}\") : Debug ON."
    else
        _info "Element \"$1\" : Off."
    fi
}

_debug_start(){
    if [ -n "${_OMS_DEBUG_LIST[${1}]}" ]
    then
        export eval "_DEBUG_${_OMS_DEBUG_LIST[${1}]}"="DEBUG"
        _debug "Signed ${_OMS_DEBUG_LIST[${1}]} On."
    else
        _error "Failed to start \"$1\"." "Debug" "13"
    fi
}

_debug_stop(){
    if [ -n "${_OMS_DEBUG_LIST[${1}]}" ] && [ -n "$(eval echo '$'"_DEBUG_${_OMS_DEBUG_LIST[${1}]}")" ]
    then
        unset eval "_DEBUG_${_OMS_DEBUG_LIST[${1}]}"
    else
        _error "Failed to start \"$1\"." "Debug" "13"
    fi
}

for i in "${OMS_DEBUG[@]}"
do
    _debug_start "$i"
done
