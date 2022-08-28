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

_logo(){
  if [ "$(checkcmd lolcat)" = "1" ]
  then
    # play 3 time an bell sound
    for _ in {1..3}; do
      # echo -e "\a"
      tput bel
    done
  
    # print logo in rainbow color
    _logo_display | lolcat -a -d 10

  else
    _logo_display
  fi

  cat <<EOF

       OhMySh - The Shell Framework
EOF
}
