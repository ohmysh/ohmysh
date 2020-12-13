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

rightprompt(){
  printf "%*s" $COLUMNS $1
}

_theme_runner(){
  if [ -f "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"  ]
  then
    source "$OMS_DIR/usr/theme/$OMS_THEME/$OMS_THEME.theme.sh"
    #PS1="\[$(tput sc; rightprompt $OMS_THEME_RIGHT; tput rc)\]\[$(OMS_GIT)\]$OMS_THEME_PS"
    PS1="$OMS_THEME_PS"
  else
    _error "Cannot found theme '$OMS_THEME'!!!" 'OhMySh' '1'
    PS1="OhMySh::NoTheme \$ "
  fi
}
