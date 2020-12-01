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

rightprompt()
{
  printf "%*s" $COLUMNS $1
}

