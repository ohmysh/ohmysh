# OhMySh Command Interface (CLI)

_helpcommand(){
  echo '
Help -- OhMySh
[Usage] ohmysh [OPTIONS]

[OPTIONS]: 
    --update    :    Update OhMySh
    --uninstall :    Uninstalling OhMySh
    --help      :    Ask help

OhMySh Command Line Interface
  '
}

_maincommand(){
  if [ -z $1 ]
  then
    _helpcommand
  elif [ "$1" = "--update" ]
  then
    _warn 'Updating OhMySh' 'CLI'
    forceUpdate=1
    source "$OMS_DIR/lib/update.sh"
    unset forceUpdate
  elif [ "$1" = "--help" ]
  then
    _helpcommand
  elif [ "$1" = "--uninstall" ]
  then
    _warn 'Are you sure to uninstall OhMySh? [Y/N]' 'CLI'
    read ch
    if [ "$ch" = "Y" ] || [ "$ch" = "y" ]
    then
      _warn 'Uninstalling OhMySh' 'CLI'
      mv "$HOME/.profile" "$HOME/.ohmysh-backup"
      rm -rf "$OMS_DIR"
      _warn 'Uninstalled OhMySh, Thanks for use!' 'CLI'
    else
      _warn 'You chose No' 'CLI'
    fi
  else
    _error "Option '$1' not found" 'CLI'
  fi
}

alias ohmysh="_maincommand $1 $2 $3 $4"


