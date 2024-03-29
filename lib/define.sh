#!/bin/bash
# Basic Function defines

# Some bash defines
shopt -s globstar
shopt -s extglob 

# Time&date defines
_oms_date_select(){
    if [ "$(date "+%8N")" = "+8N" ] || [ "$(date "+%8N")" = "8N" ]
    then
        # Bad tool.
        gdate -d "20220101" "+%x" >/dev/null 2>&1
        if [ "$?" != "0" ]
        then
            _error "'date' not available and 'gdate' cannot be found." "Define" "15"
        else
            echo "gdate"
        fi
    else
        echo "date"
    fi
}


# . Rules: _oms_date "Date" "Format" 
_oms_date(){
    if [ "$1" = "-d" ]
    then
        local SRC="$2"
        local FMT="$3"
    else
        local SRC="$1"
        local FMT="$2"
    fi
    "$(_oms_date_select)" -d "$SRC" "$FMT"
}

# Profile Signed
_oms_getprofile(){
    if [ -n "${OMS_PROFILE[0]}" ]
    then
        if grep -q "Install" <<< "${OMS_PROFILE[0]}"; then
            echo "${OMS_PROFILE[1]}"
        else
            echo "${OMS_PROFILE[0]}"
        fi
    else
        _error "Error not found." "CLI" "12"
    fi
}

alias oms_reload='. "$(_oms_getprofile)"'


# EDITOR define

export EDITOR="$editorSelect"
