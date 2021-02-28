#!/bin/bash

# Run Scripts in $OMS_CACHE/runtime-script

if [ ! -d "$OMS_CACHE/runtime-script" ]
then
    mkdir -p "$OMS_CACHE/runtime-script"
fi

for i in `ls "$OMS_CACHE/runtime-script"` ;do
    if [ ${i##*.} = 'sh' ]
    then
        . "$OMS_CACHE/runtime-script/$i"
    fi
done

