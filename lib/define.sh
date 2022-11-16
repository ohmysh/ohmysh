#!/bin/bash
# Basic Function defines

# Time&date defines
_oms_date_select(){
    if [ "$(date "+%8N")" = "+8N" ]
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
    # date -d "20220101" "+%x" >/dev/null 2>&1
    # if [ "$?" != "0" ]
    # then
    #     echo "$1"
    # else
    #     date -d "$1" "$2"
    # fi

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
