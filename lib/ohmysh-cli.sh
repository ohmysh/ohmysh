# OhMySh Command Interface (CLI)

_helpcommand(){
  cat <<EOF
                          Help --- OhMySh
[Usage]:
    ohmysh [OPTIONS] OR oms [OPTIONS]

[OPTIONS]: 
    -u  --update                :    Update OhMySh
    --uninstall                 :    Uninstalling OhMySh
    -h  --help                  :    Ask help
    -v  --version               :    Check OhMySh Version
    -t  --theme [THEME]         :    Change theme
    --themelist                 :    Get list of themes
    -p  --plugin [OPT] [PLUGIN] :    Enable or disable plugin
    plugin::[OPT]:
         start [PLUGIN]         :    Run a plugin in one go
         enable [PLUGIN]        :    Enable a plugin
         disable [PLUGIN]       :    Disable a plugin
         restart [PLUGIN]       :    Restart a plugin
    --pluginlist                :    Get list of plugins
    -a  --alias [EDITOR]        :    Config aliases (EDITOR=vi)
    -c  --cover [EDITOR]        :    Edit the cover (EDITOR=vi)
    --chsh [SHELL (sh|bash|zsh)]:    Creat config file for [SHELL]

More information about using OhMySh, visit our documents: 
- https://ohmysh.github.io/docs-v2
- https://ohmysh.gitee.io/docs-v2

OhMySh Command Line Interface $OMS_CLI_VER
EOF
}

_ohmyshdevwarn (){
    if [ "$OMS_PRE" = "PRE" ]
    then
        _warn 'You are using the development version' 'OhMySh::CLI'
        echo ' This version is still in testing and it is not an absolutely secure version. We strongly recommend that you do not use the development version.'
    fi
}

_maincommand(){
  if [ -z $1 ]
  then
    _error 'Missing parameters' 'OhMySh::CLI' '1'
    _helpcommand
  elif [ "$1" = "--update" ] || [ "$1" = "-u" ]
  then
    _info 'Updating OhMySh' 'CLI'
    forceUpdate=1
    source "$OMS_DIR/lib/update.sh"
    unset forceUpdate
    #. ~/.profile
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
      rm -rf "$OMS_CACHE"
      _info 'Uninstalled OhMySh, Thanks for use!' 'CLI'
    else
      _info 'You chose No' 'CLI'
    fi
  elif [ "$1" = "--version" ] || [ "$1" = "-v" ]
  then
    _logo
    cat <<EOF

               Version --- OhMySh
    OhMySh Version      :  $OMS_VER
    OhMySh CLI Version  :  $OMS_CLI_VER
    Last checked update :  $(cat $OMS_CACHE/update)

           Environment --- OhMySh
    OhMySh Theme        :  $OMS_THEME
    OhMySh Path         :  $OMS_DIR
    OhMySh Cache Path   :  $OMS_CACHE
    OhMySh Profile Path :  $HOME/.profile;$HOME/.bashrc
    OhMySh Logged User  :  $USER
    System Shell        :  $SHELL

    OhMySh Command Line Interface $OMS_CLI_VER

$(_ohmyshdevwarn)
EOF
  elif [ "$1" = "--theme" ] || [ "$1" = "-t" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'OhMySh::CLI' '7'
    else
      _warn "Change theme to '$2'" 'OhMySh::Theme'
      OMS_THEME_NEW="$2"
      sed -n "/OMS_THEME='$OMS_THEME'/p" $HOME/.profile | sed "s/OMS_THEME='$OMS_THEME'/OMS_THEME='$OMS_THEME_NEW'/g" $HOME/.profile > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      OMS_THEME=$OMS_THEME_NEW
      _theme_runner
    fi
  elif [ "$1" = "--themelist" ]
  then
    _info "You are using the theme: $OMS_THEME" 'OhMySh::Theme'
    echo ' List of themes:'
    ls "$OMS_DIR/usr/theme"
  elif [ "$1" = "--plugin" ] || [ "$1" = "-p" ]
  then
    if [ -z "$2" ] || [ -z "$3" ]
    then
      _error "Missing parameters" 'OhMySh::CLI' '7'
    elif [ ! -f "$OMS_DIR/usr/local/plugin/$3/$3.plugin.sh" ]
    then
      _error "Plugin not found!" 'OhMySh::Plugin' '5'
    elif [ "$2" = "start" ]
    then
      _warn "Run plugin '$3'" 'OhMySh::Plugin'
      _plugin_runner "$3"
    elif [ "$2" = "enable" ]
    then
      _warn "Enable plugin '$3'" 'OhMySh::Plugin'
      OMS_PLUGIN_NEW="$3"
      sed -n "/OMS_PLUGIN=(/p" $HOME/.profile | sed "s/(/(\"$OMS_PLUGIN_NEW\" /" $HOME/.profile > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      _plugin_runner "$OMS_PLUGIN_NEW"
    elif [ "$2" = "disable" ]
    then
      _warn "Disable plugin '$3'" 'OhMySh::Plugin'
      OMS_PLUGIN_NEW="$3"
      sed -n "/OMS_PLUGIN=(/p" $HOME/.profile | sed "s/\"$OMS_PLUGIN_NEW\" //g" $HOME/.profile > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
    elif [ "$2" = "restart" ]
    then
      _warn "Restart plugin '$3'" "OhMySh::Plugin"
      _plugin_runner "$3"
    fi
  elif [ "$1" = "--pluginlist" ]
  then
    _info "You are using these plugins:"
    echo "${OMS_PLUGIN[@]}"
    echo ' List of plugins:'
    ls "$OMS_DIR/usr/plugin"
  elif [ "$1" = "-a" ] || [ "$1" = "--alias" ]
  then
    if [ -z "$2" ]
    then
      vi "$OMS_CACHE/alias.ohmysh.sh"
    else
      $2 "$OMS_CACHE/alias.ohmysh.sh"
    fi
  elif [ "$1" = "-c" ] || [ "$1" = "--cover" ]
  then
    if [ -z "$2" ]
    then
      vi "$OMS_CACHE/cover.ohmysh.sh"
    else
      $2 "$OMS_CACHE/cover.ohmysh.sh"
    fi
  elif [ "$1" = "--chsh" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'OhMySh::CLI' '7'
      _helpcommand
    else
      _warn "Changing your shell to $2" "CLI"
      if [ "$2" = "sh" ] || [ "$2" = "/bin/sh" ]
      then
        echo '. ~/.profile' >> ~/.bashrc
      else
	    echo "OMS_OTHER_SHELL='$2'" >> "$HOME/."$2"rc"
        echo '. ~/.profile' >> "$HOME/."$2"rc"
      fi
    fi
  else
    _error "Parameters '$1' not found" 'CLI' '2'
  fi
}

alias ohmysh="_maincommand $1 $2 $3 $4"
alias oms="_maincommand $1 $2 $3 $4"

export -f _maincommand _helpcommand
export ohmysh oms
