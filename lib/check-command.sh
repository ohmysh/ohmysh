#!/bin/bash

checkcommand(){
  if [ -n "$2" ]; then
    where="::$2"
  fi
  hash "${1%% *}" 2>/dev/null || { bred " >> OhMySh$where : ERROR cannot found command \"$1\", please insall it!!! "; return 1;}

  return 0
}

checkcmd(){
    if command -v "${1%% *}" >/dev/null 2>&1; then 
        echo '1' 
    else 
        # echo the text 'Command Not Found!' in red color, the text 'Command Not Found!' is not printed in red color to stderr
        echo -e "\033[31mCommand Not Found!\033[0m" >&2
    fi
}

type_exists () {
    type "$1" &> /dev/null ;
}

#export -f checkcmd
