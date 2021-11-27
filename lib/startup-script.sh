#!/bin/bash

# Run Scripts in $OMS_CACHE/startup-script

if [ ! -d "$OMS_CACHE/startup-script" ]
then
    mkdir -p "$OMS_CACHE/startup-script"
fi

find "$OMS_CACHE/startup-script" -maxdepth 1 -type f -printf "%f\n" | while IFS= read -r i
do
    if [ "${i##*.}" = 'sh' ]
    then
        . "$OMS_CACHE/startup-script/$i"
    fi
done

