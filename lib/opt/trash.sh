#!/bin/bash

# OhMySh Deleting Trash (bin) Manager
# Starting on Dec, 2021
# Save trash on "$OMS_CACHE/trash/*"
# Trash name rule "FILE_%^%_PATH_%^%_NAME.EXT"

# Realpath checking

if [ "$(checkcmd "realpath")" != "1" ]
then
    _error "Cannot found command 'realpath'!" "TrashManager" "9"
else
    mkdir -p "$OMS_CACHE/trash"
fi

# Trash-Auto-Deleting Service

if [ -n "$trashAutoDeleteService" ] && [ "$trashAutoDeleteService" = "Enable" ]
then
    find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | while IFS= read -r i
    do
        fullfilename="${i//"_%^%_"/"/"}"
        filename="${fullfilename%%"_%backup%_"*}"
        timename="${fullfilename##*"_%backup%_"}"
        if [ "$timename" != "$filename" ]
        then
            editdate="${timename:0:4}/${timename:4:2}/${timename:6:2} ${timename:9:2}:${timename:11:2}:${timename:13:2}.${timename:16:8}"
            secdate="$(date -d "$editdate" "+%s")"
            time1=$((($(date +%s)-secdate)/86400))
            if [ "$time1" -gt "$trashAutoDeleteConfigDate" ]
            then
                _warn "The file $filename last over $trashAutoDeleteConfigDate days, deleting..."
                rm -rf "$OMS_CACHE/trash/$i"
            fi
        fi
    done
fi

helptrash(){
    cat <<EOF
              trash help:
trash:
  trash FILE       :  move a file/folder to the bin
lstrash:
  lstrash          :  get a list of the bin
  lstrash KEY      :  search KEY
  lstrash PATH     :  search file on PATH
rmtrash:
  rmtrash FILE     :  remove FILE
  rmtrash KEY      :  search KEY to remove
  rmtrash -a       :  remove all files
retrash:
  retrash FILE     :  restore FILE
  retrash KEY      :  search KEY to restore
EOF
}

trash(){
    if [ -z "$1" ]
    then
        _error 'Missing parameters' 'OhMySh::TrashManager' '10'
    else
        if [ -f "$1" ] || [ -d "$1" ]
        then
            RP="$(realpath "$1")"
            NP="${RP//"/"/"_%^%_"}"
            NP="${NP//" "/"_%SPACE%_"}"
            _info "Deleting '$RP'"
            # echo $NP
            # if [ -f "$OMS_CACHE/trash/$NP" ] || [ -d "$OMS_CACHE/trash/$NP" ]
            # then
                # mv "$OMS_CACHE/trash/$NP" "$OMS_CACHE/trash/${NP}_%backup%_$(date +%Y%m%d_%H%M%S_%8N)"
            # fi
            # mv "$RP" "$OMS_CACHE/trash/$NP"
            mv "$RP" "$OMS_CACHE/trash/${NP}_%backup%_$(date +%Y%m%d_%H%M%S_%8N)"
        else
            _error "No such file or directory." "TrashManager"
        fi
    fi
}

lstrash(){
    # ls "$OMS_CACHE/trash"
    if [ -n "$1" ]
    then
        search_1="$(realpath "$1")"
        search="${search_1//"/"/"_%^%_"}"
    else
        search=""
    fi
    printf " %-22s %s\n" "Date deleted" "File name"
    find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | grep "$search" | while IFS= read -r i
    do
        fullfilename="${i//"_%^%_"/"/"}"
        # echo $fullfilename
        fullfilename="${fullfilename//"_%SPACE%_"/" "}"
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
                printf " %-22s \033[34m%s\033[0m\n" "$outdate" "$filename"
            elif [ -f "$OMS_CACHE/trash/$i" ]
            then
                printf " %-22s %s\n" "$outdate" "$filename"
            fi
        fi
    done
}

rmtrash(){
#     if [ -z "$1" ]
#     then
#         _error 'Missing parameters' 'OhMySh::TrashManager' '10'
#     else
        if [ "$1" = "-a" ]
        then
            _warn "You are going to delete all the caching trashes. Are you sure? [y/n]" "TrashManager"
            read -r -s -n1 _cfm
            if [ "$_cfm" = "y" ] || [ "$_cfm" = "Y" ]
            then
                _warn "You chose yes." "TrashManager"
                rm -rf "$OMS_CACHE/trash/*"
            else
                blue "You chose no. Nothing will be changed."
            fi
        else
            RP="$1"
            NP="${RP//"/"/"_%^%_"}"
            _warn "Deleting $RP..."
#             echo $NP
#             ls "$OMS_CACHE/trash/" | grep "$NP"
#             local _rmlist=()
#             find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | grep "$NP" | while IFS= read -r i
#             do
#                 _rmlist=("${_rmlist[@]}" "$i")
#                 echo "$i ${#_rmlist[@]}"
#             done
            _rmlist=( $(find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | grep "$NP") )
            _count="${#_rmlist[@]}"
            _info "Found ${#_rmlist[@]} result(s)."
            if [ "$_count" = "0" ]
            then
                _error "The path is not correct." "OhMySh::TrashManager"
                return
                _error "Command return is broken!"
            elif [ "$_count" != "1" ]
            then
                printf " %-4s %-22s %s\n" "#" "Date deleted" "File name"
                for ((i=0;i<_count;i++))
                do
                    fullfilename="${_rmlist[i]//"_%^%_"/"/"}"
                    fullfilename="${fullfilename//"_%SPACE%_"/" "}"
                    filename="${fullfilename%%"_%backup%_"*}"
                    timename="${fullfilename##*"_%backup%_"}"
                    if [ "$timename" != "$filename" ]
                    then
                        editdate="${timename:0:4}/${timename:4:2}/${timename:6:2} ${timename:9:2}:${timename:11:2}:${timename:13:2}.${timename:16:8}"
                        outdate="$(date -d "$editdate" "+%F %H:%M:%S")"
                        if [ -d "$OMS_CACHE/trash/${_rmlist[i]}" ]
                        then
                            printf " %-4s %-22s \033[34m%s\033[0m\n" "$i" "$outdate" "$filename"
                        elif [ -f "$OMS_CACHE/trash/${_rmlist[i]}" ]
                        then
                            printf " %-4s %-22s %s\n" "$i" "$outdate" "$filename"
                        fi
                    fi
                done
                _info "Which one do you want to delete? [0-$((_count-1))]"
                read -r _delnum
                if [ -z "$_delnum" ] || [ "$_delnum" -lt "0" ] || [ "$_delnum" -ge "$_count" ]
                then
                    _error "Invalid input."
                    return
                fi
                fullfilename="${_rmlist[_delnum]//"_%^%_"/"/"}"
                fullfilename="${fullfilename//"_%SPACE%_"/" "}"
                filename="${fullfilename%%"_%backup%_"*}"
                _warn "Deleting ${filename}..."
                rm -rf "$OMS_CACHE/trash/${_rmlist[_delnum]}"
            fi
        fi
#     fi
}

retrash(){
#     if [ -z "$1" ]
#     then
#         _error 'Missing parameters' 'OhMySh::TrashManager' '10'
#     else
        RP="$1"
        NP="${RP//"/"/"_%^%_"}"
        _warn "Restoring $RP..."
#         _rmlist=()
#         find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | grep $NP | while IFS= read -r i
#         do
#             _rmlist+=("$i")
#         done
        _rmlist=( $(find "$OMS_CACHE/trash" -maxdepth 1 -printf "%f\n" | grep "$NP") )
        _count="${#_rmlist[@]}"
        _info "Found $_count result(s)."
        if [ "$_count" = "0" ]
        then
            _error "The path is not correct." "OhMySh::TrashManager"
            return
            _error "Command return is broken!"
        elif [ "$_count" != "1" ]
        then
            printf " %-4s %-22s %s\n" "#" "Date deleted" "File name"
            for ((i=0;i<_count;i++))
            do
                fullfilename="${_rmlist[i]//"_%^%_"/"/"}"
                fullfilename="${fullfilename//"_%SPACE%_"/" "}"
                filename="${fullfilename%%"_%backup%_"*}"
                timename="${fullfilename##*"_%backup%_"}"
                if [ "$timename" != "$filename" ]
                then
                    editdate="${timename:0:4}/${timename:4:2}/${timename:6:2} ${timename:9:2}:${timename:11:2}:${timename:13:2}.${timename:16:8}"
                    outdate="$(date -d "$editdate" "+%F %H:%M:%S")"
                    if [ -d "$OMS_CACHE/trash/${_rmlist[i]}" ]
                    then
                        printf " %-4s %-22s \033[34m%s\033[0m\n" "$i" "$outdate" "$filename"
                    elif [ -f "$OMS_CACHE/trash/${_rmlist[i]}" ]
                    then
                        printf " %-4s %-22s %s\n" "$i" "$outdate" "$filename"
                    fi
                fi
            done
            _info "Which one do you want to delete? [0-$((_count-1))]"
            read -r _delnum
            if [ -z "$_delnum" ] || [ "$_delnum" -lt "0" ] || [ "$_delnum" -ge "$_count" ]
            then
                _error "Invalid input."
                return
            fi
            fullfilename="${_rmlist[_delnum]//"_%^%_"/"/"}"
            fullfilename="${fullfilename//"_%SPACE%_"/" "}"
            filename="${fullfilename%%"_%backup%_"*}"
            _warn "Restoring ${filename}..."
            mv -f "$OMS_CACHE/trash/${_rmlist[_delnum]}" "$filename"
        fi
#     fi
}
