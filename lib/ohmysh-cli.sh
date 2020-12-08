# OhMySh Command Interface (CLI)

_helpcommand(){
  cat <<EOF
               Help --- OhMySh
[Usage] ohmysh [OPTIONS]

[OPTIONS]: 
    --update         :    Update OhMySh
    --uninstall      :    Uninstalling OhMySh
    -h   --help      :    Ask help
    -v   --version   :    Check OhMySh Version

OhMySh Command Line Interface
EOF
}

_maincommand(){
  if [ -z $1 ]
  then
    _error 'Option not found' 'CLI' '1'
    _helpcommand
  elif [ "$1" = "--update" ]
  then
    _warn 'Updating OhMySh' 'CLI'
    forceUpdate=1
    source "$OMS_DIR/lib/update.sh"
    unset forceUpdate
  elif [ "$1" = "--help" ] || [ "$1" = "-h" ]
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
  elif [ "$1" = "--version" ] || [ "$1" = "-v" ]
  then
    cat <<EOF
           Version --- OhMySh
OhMySh Version      :  $OMS_VER
OhMySh CLI Version  :  $OMS_CLI_VER

       Environment --- OhMySh
OhMySh Theme        :  $OMS_THEME
OhMySh Path         :  $OMS_DIR
OhMySh Cache Path   :  $OMS_CACHE
OhMySh Profile Path :  $HOME/.profile
OhMySh Logged User  :  $USER
System Shell        :  $SHELL

OhMySh Command Line Interface
EOF
  else
    _error "Option '$1' not found" 'CLI' '2'
  fi
}

alias ohmysh="_maincommand $1 $2 $3 $4"


