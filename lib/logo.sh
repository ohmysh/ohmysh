#!/bin/bash

_logo(){
cat <<EOF
        ____  __   __  ___     ___ _
       / __ \/ /  /  |/  /_ __/ __| |_
      / /_/ / _ \/ /|_/ / // /\__ \ . \  
      \____/_//_/_/  /_/\_, / |___/_||_| [] [] []
                       /___/

EOF
}

_des(){
  # play 3 time an bell sound
  for i in {1..3}; do
    echo -e "\a"
  done
  
  # print logo in rainbow color
  _logo | /usr/games/lolcat -a -d 10


  cat <<EOF

       OhMySh - The Shell Framework
EOF
}

export -f _logo _des
