#!/bin/bash

# OhMySh theme & title provider.

if [ "$(checkcmd 'declare')" != '1' ]
then
    _error 'Your shell is too old, please check if your shell support "declare".' 'OhMySh' '8'
fi


# set theme color
declare -A COLOR
COLOR[reset]='\[\033[00m\]'
COLOR[black]='\[\033[00;30m\]'
COLOR[red]='\[\033[00;31m\]'
COLOR[green]='\[\033[00;32m\]'
COLOR[brown]='\[\033[00;33m\]'
COLOR[blue]='\[\033[00;34m\]'
COLOR[purple]='\[\033[00;35m\]'
COLOR[cyan]='\[\033[00;36m\]'
COLOR[white]='\[\033[00;37m\]'
COLOR[bblack]='\[\033[01;30m\]'
COLOR[bred]='\[\033[01;31m\]'
COLOR[bgreen]='\[\033[01;32m\]'
COLOR[bbrown]='\[\033[01;33m\]'
COLOR[bblue]='\[\033[01;34m\]'
COLOR[bpurple]='\[\033[01;35m\]'
COLOR[bcyan]='\[\033[01;36m\]'
COLOR[bwhite]='\[\033[01;37m\]'
export COLOR

# set theme background color
declare -A BGCOLOR
BGCOLOR[black]='\[\033[00;40m\]'
BGCOLOR[red]='\[\033[00;41m\]'
BGCOLOR[green]='\[\033[00;42m\]'
BGCOLOR[brown]='\[\033[00;43m\]'
BGCOLOR[blue]='\[\033[00;44m\]'
BGCOLOR[purple]='\[\033[00;45m\]'
BGCOLOR[cyan]='\[\033[00;46m\]'
BGCOLOR[white]='\[\033[00;47m\]'
BGCOLOR[black]='\[\033[01;40m\]'
BGCOLOR[bred]='\[\033[01;41m\]'
BGCOLOR[bgreen]='\[\033[01;42m\]'
BGCOLOR[bbrown]='\[\033[01;43m\]'
BGCOLOR[bblue]='\[\033[01;44m\]'
BGCOLOR[bpurple]='\[\033[01;45m\]'
BGCOLOR[bcyan]='\[\033[01;46m\]'
BGCOLOR[bwhite]='\[\033[01;47m\]'
export BGCOLOR

rightprompt(){
  printf "%*s" "$COLUMNS" "$1"
}

_title_runner(){
    if [ -z "$OMS_TITLE" ]
    then
        OMS_TITLE="$(pwd)"
    fi
    echo -n -e "\033]0;$OMS_TITLE\007"
}

_theme_runner(){
  if [ -f "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"  ]
  then
    source "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"
    #PS1="\[$(tput sc; rightprompt $OMS_THEME_RIGHT; tput rc)\]\[$(OMS_GIT)\]$OMS_THEME_PS"
  elif [ -f "$OMS_DIR/usr/local/theme/$OMS_THEME/$OMS_THEME.theme.sh" ]
  then
    source "$OMS_DIR/usr/local/theme/$OMS_THEME/$OMS_THEME.theme.sh"
  else
    _error "Cannot found theme '$OMS_THEME'!!!" 'Theme' '4'
    PS1="OhMySh Theme Not Found \$ "
  fi
  
  if [ "$OMS_TITLE" != "Disable" ]
  then
    PS1="\[\$(_title_runner)\]$PS1"
  fi
  PS1="\[\$(_bcd_rec)\]$PS1"
}
