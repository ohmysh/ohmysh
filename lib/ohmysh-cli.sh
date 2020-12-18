# OhMySh Command Interface (CLI)

_helpcommand(){
  cat <<EOF
                          Help --- OhMySh
[Usage]:
    ohmysh [OPTIONS] OR oms [OPTIONS]

[OPTIONS]: 
    --update                    :    Update OhMySh
    --uninstall                 :    Uninstalling OhMySh
    -h  --help                  :    Ask help
    -v  --version               :    Check OhMySh Version
    -t  --theme [THEME]         :    Change theme
    --themelist                 :    Get list of themes
    -p  --plugin [OPT] [PLUGIN] :    Enable or disable plugin
    plugin::[OPT]:
         enable [PLUGIN]        :    Enable a plugin
         disable [PLUGIN]       :    Disable a plugin
         restart [PLUGIN]       :    Restart a plugin
    --pluginlist                :    Get list of plugins

OhMySh Command Line Interface $OMS_CLI_VER
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

OhMySh Command Line Interface $OMS_CLI_VER
EOF
  elif [ "$1" = "--theme" ] || [ "$1" = "-t" ]
  then
    if [ -z "$2" ]
    then
      _error "Cannot read your new theme" 'CLI::Theme'
    else
      _warn "Change theme to '$2'" 'CLI::Theme'
      OMS_THEME_NEW="$2"
      sed -n "/OMS_THEME='$OMS_THEME'/p" $HOME/.profile | sed "s/OMS_THEME='$OMS_THEME'/OMS_THEME='$OMS_THEME_NEW'/g" $HOME/.profile > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      OMS_THEME=$OMS_THEME_NEW
      _theme_runner
    fi
  elif [ "$1" = "--themelist" ]
  then
    ls "$OMS_DIR/usr/theme"
  elif [ "$1" = "--plugin" ] || [ "$1" = "-p" ]
  then
    if [ -z "$2" ] || [ -z "$3" ]
    then
      _error "Cannot read sub-option" 'CLI::Plugin'
      _helpcommand
    elif [ "$2" = "enable" ]
    then
      _warn "Enable plugin '$3'" 'CLI::Plugin'
      OMS_PLUGIN_NEW="$3"
      sed -n "/OMS_PLUGIN=(/p" $HOME/.profile | sed "s/(/($OMS_PLUGIN_NEW /" $HOME/.profile > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      _plugin_runner "$OMS_PLUGIN_NEW"
    elif [ "$2" = "disable" ]
    then
      _warn "Disable plugin '$3'" 'CLI::Plugin'
      OMS_PLUGIN_NEW="$3"
      sed -n "/OMS_PLUGIN=(/p" $HOME/.profile | sed "s/$OMS_PLUGIN_NEW //g" $HOME/.profile > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
    elif [ "$2" = "restart" ]
    then
      _warn "Restart plugin '$3'" "CLI::Plugin"
      _plugin_runner "$3"
    fi
  elif [ "$1" = "--pluginlist" ]
  then
    ls "$OMS_DIR/usr/plugin"
  else
    _error "Option '$1' not found" 'CLI' '2'
  fi
}

alias ohmysh="_maincommand $1 $2 $3 $4"
alias oms="_maincommand $1 $2 $3 $4"

