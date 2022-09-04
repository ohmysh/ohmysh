#!/bin/bash

_logo_display(){
cat <<EOF
        ____  __   __  ___     ___ _
       / __ \/ /  /  |/  /_ __/ __| |_
      / /_/ / _ \/ /|_/ / // /\__ \ . \  
      \____/_//_/_/  /_/\_, / |___/_||_| [] [] []
                       /___/

EOF
}

_oms_lolcat_check(){
  if [ "$(checkcmd lolcat)" = "1" ] && [ "$configLOLCAT" != 'Disable' ]
  then
    if [ "$configLOLCAT" != 'Enable' ]
    then
      if [ -f "$configLOLCAT" ]
      then
        echo "1"
      else
        echo "0"
      fi
    else
      echo "1"
    fi
  else
    echo "0"
  fi
}

_oms_lolcat(){
  # Do this before _oms_lolcat_check.
  if [ "$configLOLCAT" != 'Enable' ]
  then
    echo "$configLOLCAT"
  else
    echo "lolcat"
  fi
}

# usage:
# 1. Checking: _oms_lolcat_check
# 2. Using: $(_oms_lolcat) -xxx

_logo(){
  if [ "$(_oms_lolcat_check)" = "1" ]
  then
    # play 3 time an bell sound
    for _ in {1..5}; do
      # echo -e "\a"
      tput bel
    done
  
    # print logo in rainbow color
    _logo_display | "$(_oms_lolcat)" -a -d 10

  else
    _logo_display
  fi

  cat <<EOF
         OhMySh - The Shell Framework
EOF
}
