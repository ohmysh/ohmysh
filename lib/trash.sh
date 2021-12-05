#!/bin/bash

# OhMySh Deleting Trash (bin) Manager
# Starting on Dec, 2021
# Save trash on "$OMS_CACHE/trash/*"
# Trash name rule "FILE_%^%_PATH_%^%_NAME.EXT"

if [ "$(checkcmd "realpath")" != "1" ]
then
    _error "Cannot found command 'realpath'!" "TrashManager" "9"
else
    mkdir -p "$OMS_CACHE/trash"
fi

del(){
    if [ -z "$1" ]
    then
        _error 'Missing parameters' 'OhMySh::TrashManager' '10'
    else
        RP="$(realpath "$1")"
        NP="${RP//"/"/"_%^%_"}"
        _info "Deleting '$RP'"
        # if [ -f "$OMS_CACHE/trash/$NP" ] || [ -d "$OMS_CACHE/trash/$NP" ]
        # then
            # mv "$OMS_CACHE/trash/$NP" "$OMS_CACHE/trash/${NP}_%backup%_$(date +%Y%m%d_%H%M%S_%8N)"
        # fi    
        # mv "$RP" "$OMS_CACHE/trash/$NP"
        mv "$RP" "$OMS_CACHE/trash/${NP}_%backup%_$(date +%Y%m%d_%H%M%S_%8N)"
    fi
}

lstrash(){
    # ls "$OMS_CACHE/trash"
    find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | while IFS= read -r i
    do
        fullfilename="${i//"_%^%_"/"/"}"
        # echo $fullfilename
        filename="${fullfilename%%"_%backup%_"*}"
        timename="${fullfilename##*"_%backup%_"}"
        # echo "$timename"
        if [ "$timename" != "$filename" ]
        then
            # if [ -d "$OMS_CACHE/trash/$i" ]
            # then
                # blue "latest version       -  $filename"
            # elif [ -f "$OMS_CACHE/trash/$i" ]
            # then
                # echo "latest version       -  $filename"
            # fi
        # else
            editdate="${timename:0:4}/${timename:4:2}/${timename:6:2} ${timename:9:2}:${timename:11:2}:${timename:13:2}.${timename:16:8}"
            outdate="$(date -d "$editdate" "+%F %H:%M:%S")"
            if [ -d "$OMS_CACHE/trash/$i" ]
            then
                blue "$outdate  -  $filename"
            elif [ -f "$OMS_CACHE/trash/$i" ]
            then
                echo "$outdate  -  $filename"
            fi
        fi
    done
}

