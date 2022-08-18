#!/bin/bash

# OhMySh theme & title provider.

if [ "$(checkcmd 'declare')" != '1' ]
then
    _error 'Your shell is too old, please check if your shell support "declare".' 'OhMySh' '8'
fi


# set theme color
declare -A COLOR
COLOR[reset]='\033[0m'
COLOR[black]='\033[30m'
COLOR[red]='\033[31m'
COLOR[green]='\033[32m'
COLOR[brown]='\033[33m'
COLOR[blue]='\033[34m'
COLOR[purple]='\033[35m'
COLOR[cyan]='\033[36m'
COLOR[white]='\033[37m'
export COLOR

# set theme background color
declare -A BGCOLOR
BGCOLOR[black]='\033[40m'
BGCOLOR[red]='\033[41m'
BGCOLOR[green]='\033[42m'
BGCOLOR[brown]='\033[43m'
BGCOLOR[blue]='\033[44m'
BGCOLOR[purple]='\033[45m'
BGCOLOR[cyan]='\033[46m'
BGCOLOR[white]='\033[47m'
export BGCOLOR

rightprompt(){
  printf "%*s" "$COLUMNS" "$1"
}

# if [ ! -f "$OMS_CACHE/title.ohmysh.sh" ]
# then
#   if [ -f "$OMS_DIR/lib/etc/title.etc.sh" ]
#   then
#     cp "$OMS_DIR/lib/etc/title.etc.sh" "$OMS_CACHE/title.ohmysh.sh"
#   else
#     touch "$OMS_CACHE/title.ohmysh.sh"
#   fi
# fi
# source "$OMS_CACHE/title.ohmysh.sh"

trap 'echo -ne "\033]0;${PWD##*/}: (${BASH_COMMAND})\007"' DEBUG

# _title_runner(){
#     if [ -z "$OMS_TITLE" ]
#     then
#         OMS_TITLE='${PWD##*/}'
#     fi
#     echo -n -e "\033]0;$OMS_TITLE\007"
# }

_theme_runner(){
  if [ -f "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"  ]
  then
    [ -n "$_DEBUG_THEME" ] && _debug "Enabling theme $OMS_THEME from official package." "Theme"
    [ -n "$_DEBUG_THEME" ] && cat "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"
    [ -n "$_DEBUG_THEME" ] && echo " ----------------------- "
    source "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"
    #PS1="\[$(tput sc; rightprompt $OMS_THEME_RIGHT; tput rc)\]\[$(OMS_GIT)\]$OMS_THEME_PS"
    #PS1="$OMS_THEME_PS"
  elif [ -f "$OMS_DIR/usr/local/theme/$OMS_THEME/$OMS_THEME.theme.sh" ]
  then
    [ -n "$_DEBUG_THEME" ] && _debug "Enabling theme $OMS_THEME from local package." "Theme"
    [ -n "$_DEBUG_THEME" ] && cat "$OMS_DIR/usr/local/theme/$OMS_THEME/$OMS_THEME.theme.sh"
    [ -n "$_DEBUG_THEME" ] && echo " ----------------------- "
    source "$OMS_DIR/usr/local/theme/$OMS_THEME/$OMS_THEME.theme.sh"
  else
    [ -n "$_DEBUG_THEME" ] && _debug "Theme $OMS_THEME can not be found." "Theme"
    _error "Cannot found theme '$OMS_THEME'!!!" 'Theme' '4'
    PS1="OhMySh Theme Not Found \$ "
  fi
  [ -n "$_DEBUG_THEME" ] && _debug "The PS1 is set to \"$PS1\"." "Theme"
  
  # if [ "$OMS_TITLE" != "Disable" ]
  # then
  #   PS1="\$(_title_runner)$PS1"
  # fi
}

#export -f _theme_runner
