#!/bin/bash

# Run Scripts in $OMS_CACHE/runtime-script

if [ ! -d "$OMS_CACHE/runtime-script" ]
then
    mkdir -p "$OMS_CACHE/runtime-script"
fi

#find "$OMS_CACHE/runtime-script" -maxdepth 1 -type f -printf "%f\n" | while IFS= read -r i
for file in "$OMS_CACHE/runtime-script/"*
do
    i="${file##"$OMS_CACHE/runtime-script/"}"
    if [ "${i##*.}" = "sh" ]
    then
        . "${OMS_CACHE}/runtime-script/${i}"
        rm -f "${OMS_CACHE}/runtime-script/${i}"
    fi
done

