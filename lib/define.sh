#!/bin/bash
# Basic Function defines

# Time&date defines
_oms_date(){
    date -d "20220101" "+%x" >/dev/null 2>&1
    if [ "$?" != "0" ]
    then
        echo "$1"
    else
        date -d "$1" "$2"
    fi
}