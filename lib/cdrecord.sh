#!/bin/bash

# 'cd' record.
# provide a way to back to last directory.

export OMS_BCD_ID="$("$(_oms_date_select)" +%Y%m%d)-$RANDOM$RANDOM"
export OMS_BCD_TOP="0"
export OMS_BCD_LIST=("$configStartPath")

mkdir -p "$OMS_CACHE/tmp/bcd/$OMS_BCD_ID"

_bcd_get_top(){
    echo "$(<"$OMS_CACHE/tmp/bcd/$OMS_BCD_ID/top")"
}

_bcd_put_top(){
    echo "$1" > "$OMS_CACHE/tmp/bcd/$OMS_BCD_ID/top"
}

_bcd_get_id(){
    echo "$(<"$OMS_CACHE/tmp/bcd/$OMS_BCD_ID/$1")"
}

_bcd_put_id(){
    echo "$2" > "$OMS_CACHE/tmp/bcd/$OMS_BCD_ID/$1"
}

_bcd_put_top "0"
_bcd_put_id "0" "$HOME"

_bcd_rec(){
    # if [ "$(pwd)" != "${OMS_BCD_LIST[OMS_BCD_TOP]}" ]
    # then
    #     echo "$(pwd)"
    #     echo "${OMS_BCD_LIST[OMS_BCD_TOP]}"
    #     # export OMS_BCD_LIST+=("$(pwd)")
    #     # export OMS_BCD_TOP=$(($OMS_BCD_TOP+1))
        
    #     echo "$OMS_BCD_TOP"
    # fi

    bcdtop="$(_bcd_get_top)"
    bcdnow="$(_bcd_get_id "$bcdtop")"
    if [ "$bcdnow" != "$(pwd)" ]
    then
        _bcd_put_top "$((bcdtop+1))"
        _bcd_put_id "$((bcdtop+1))" "$(pwd)"
        # echo "$((bcdtop+1)) $(pwd)"
    fi
}

_bcd(){
    if [ -z "$1" ]
    then
        local _d="1"
    else
        local _d="$1"
    fi
    # ((_tmp_OMS_BCD_TOP=OMS_BCD_TOP-_d))
    # echo "$_tmp_OMS_BCD_TOP"
    # if [ "$_tmp_OMS_BCD_TOP" -gt "0" ]
    # then
        # for ((i=OMS_BCD_TOP;i>=_tmp_OMS_BCD_TOP;i=i-1))
        # do
        #     unset ${OMS_BCD_LIST[$i]}
        # done
    #     OMS_BCD_TOP="$_tmp_OMS_BCD_TOP"
    #     _info "Backing to ${OMS_BCD_LIST[$OMS_BCD_TOP]}"
    #     cd "${OMS_BCD_LIST[$OMS_BCD_TOP]}"
    # else
    #     _error "No way!"
    # fi

    bcdtop="$(_bcd_get_top)"
    if [ "$((bcdtop-_d))" -ge "0" ]
    then
        bcdto="$(_bcd_get_id "$((bcdtop-_d))")"
        _info "Backing to $bcdto..."
        _bcd_put_top "$((bcdtop-_d))"
        cd "$bcdto"
    else
        _error "No way!"
    fi
}

