#!/bin/bash

# Run Scripts in $OMS_CACHE/runtime-script

if [ ! -d "$OMS_CACHE/runtime-script" ]
then
    mkdir -p "$OMS_CACHE/runtime-script"
fi

ls "$OMS_CACHE/runtime-script" | while IFS= read -r i
    if [ "${i##*.}" = "sh" ]
    then
        . "${OMS_CACHE}/runtime-script/${i}"
        rm -f "${OMS_CACHE}/runtime-script/${i}"
    fi
done

