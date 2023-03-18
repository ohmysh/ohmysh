#!/bin/bash

# Run Scripts in $OMS_CACHE/startup-script

if [ ! -d "$OMS_CACHE/startup-script" ]
then
    mkdir -p "$OMS_CACHE/startup-script"
fi

for file in "$OMS_CACHE/startup-script/"*
do
    i="${file##"$OMS_CACHE/startup-script/"}"
    if [ "${i##*.}" = 'sh' ]
    then
        . "$OMS_CACHE/startup-script/$i"
    fi
done

