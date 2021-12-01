# OhMySh Theme YS

function _GIT_T(){
  if [ -n "$(OMS_GIT)" ]
  then
    echo -e "on git:${COLOR[cyan]}$(OMS_GIT)${COLOR[reset]}"
  fi
}

PS1="\n${COLOR[blue]}#${COLOR[reset]} ${COLOR[cyan]}\u${COLOR[reset]} @ ${COLOR[green]}\h${COLOR[reset]} in ${COLOR[brown]}\w${COLOR[reset]} \$(_GIT_T) [\$(date +%H:%M:%S)]\n${COLOR[red]}\$${COLOR[reset]} "

