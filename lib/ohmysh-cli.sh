#!/bin/bash
# OhMySh Command Interface (CLI)

_helpcommand(){
  cat <<EOF
                          Help --- OhMySh
[Usage]:
    oms [OPTIONS]
    ohmysh [OPTIONS]

[OPTIONS]: 
    -u  --update                :    Update OhMySh
    --uninstall                 :    Uninstalling OhMySh
    -h  --help                  :    Ask help
    -v  --version               :    Check OhMySh Version
    -t  --theme [THEME]         :    Change theme
                list            :    Get list of themes
    -p  --plugin [OPT] [PLUGIN] :    Enable or disable plugin
    plugin::[OPT]:
         start [PLUGIN]         :    Run a plugin in one go
         enable [PLUGIN]        :    Enable a plugin
         disable [PLUGIN]       :    Disable a plugin
         list                   :    Get list of plugins
    -a  --alias (EDITOR)        :    Config aliases (EDITOR=vi)
    -c  --cover (EDITOR)        :    Edit the cover (EDITOR=vi)
    -e  --advconfig (EDITOR)    :    Edit the cover (EDITOR=vi)
    -r  --reload                :    Reload OhMySh
    --chsh [SHELL (sh/bash/zsh)]:    Creat config file for [SHELL]
    --channel (stable/dev)      :    Join/leave development channel
    --debug [NAME] (-/on/off)   :    Check/set/unset a debug flag.
            list                :    Get debug flags list.

More information about using OhMySh, visit our documents: 
- https://ohmysh.github.io/docs-v2
- https://ohmysh.gitee.io/docs-v2 (for Chinese)
EOF
}

_ohmyshdevwarn(){
    if [ "$OMS_PRE" = "PRE" ]
    then
        _warn 'You are using the development version' 'OhMySh'
        echo ' This version is still in testing and it is not an absolutely secure version. We strongly recommend that you do not use the development version.'
    fi
}

_ohmyshprofile(){
    _oms_getprofile
}

_comp_output(){
    if [ -n "$BCVER" ]
    then
        cat <<EOX
    Completion Version  :  $BCVER
    Completion Status   :  $OMSBC_status
    Completion Platform :  $OMSBC_plat ($bashcompletionPlatform)
    Completion Path     :  $OMSBC_path
EOX
    else
        echo "    Completion Status   :  Disable"
    fi
}

_cli_debug_output(){
  if [ -n "$(_debug_list_on)" ]
  then
    cat <<EOX
    Debug list          :  $(_debug_list_on)
EOX
  fi
}

oms(){
  if [ -z "$1" ]
  then
    _error 'Missing parameters' 'CLI' '1'
    _helpcommand
  elif [ "$1" = "--update" ] || [ "$1" = "-u" ]
  then
    _info 'Updating OhMySh' 'CLI'
    forceUpdate=1
    source "$OMS_DIR/lib/update.sh"
    unset forceUpdate
#     oms_reload
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

                     Version
    OhMySh Version      :  $OMS_VER
    Update channel      :  $(_oms_update_channel_fetch)
    Last checked update :  $(date -d "$(cat "$OMS_CACHE/update")" "+$dateFormat" | echo "$(cat "$OMS_CACHE/update")") ($configUpdate)

                   Environment
    OhMySh Path         :  $OMS_DIR
    OhMySh Cache Path   :  $OMS_CACHE
    OhMySh Profile Path :  $(_ohmyshprofile)
    OhMySh Logged User  :  $USER
    System Shell        :  $SHELL
    OhMySh Theme        :  $OMS_THEME
    OhMySh Plugins      :  ${OMS_PLUGIN[@]}
$(_comp_output)
$(_cli_debug_output)

$(_ohmyshdevwarn)
EOF
  elif [ "$1" = "--theme" ] || [ "$1" = "-t" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'CLI' '7'
    elif [ "$2" = "list" ]
    then
      _info "You are using the theme: $OMS_THEME" 'Theme'
      _log ' List of themes:'
      ls "$OMS_DIR/usr/theme"
      ls "$OMS_DIR/usr/local/theme"
      # echo $(cd "$OMS_DIR/usr/theme" && echo !("readme.md"))
    else
      _warn "Change theme to '$2'" 'Theme'
      OMS_THEME_NEW="$2"
      sed -n "/OMS_THEME='$OMS_THEME'/p" "$HOME/.profile" | sed "s/OMS_THEME='$OMS_THEME'/OMS_THEME='$OMS_THEME_NEW'/g" "$HOME/.profile" > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      OMS_THEME=$OMS_THEME_NEW
      _theme_runner
    fi
  elif [ "$1" = "--themelist" ]
  then
    _info "You are using the theme: $OMS_THEME" 'Theme'
    echo ' List of themes:'
    ls "$OMS_DIR/usr/theme"
    _warn "The option \"--themelist\" has already expired. Use \"oms -t list\""
  elif [ "$1" = "--plugin" ] || [ "$1" = "-p" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'CLI' '7'
    elif [ "$2" = "list" ]
    then
      _info "You are using these plugins:"
      echo "${OMS_PLUGIN[@]}"
      _log ' List of plugins:'
      ls "$OMS_DIR/usr/plugin"
      ls "$OMS_DIR/usr/local/plugin"
      # echo !("readme.md")
    elif [ -z "$3" ]
    then
      _error "Missing parameters" 'OhMySh::CLI' '7'
    elif [ ! -f "$OMS_DIR/usr/local/plugin/$3/$3.plugin.sh" ] && [ ! -f "$OMS_DIR/usr/plugin/$3/$3.plugin.sh" ]
    then
      _error "Plugin not found!" 'Plugin' '5'
    elif [ "$2" = "start" ]
    then
      _warn "Run plugin '$3'" 'Plugin'
      _plugin_runner "$3"
    elif [ "$2" = "enable" ]
    then
      _warn "Enable plugin '$3'" 'Plugin'
      OMS_PLUGIN_NEW="$3"
      sed -n "/OMS_PLUGIN=(/p" "$HOME/.profile" | sed "s/PLUGIN=(/PLUGIN=(\"$OMS_PLUGIN_NEW\" /" "$HOME/.profile" > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      OMS_PLUGIN+=("$OMS_PLUGIN_NEW")
      _plugin_runner "$OMS_PLUGIN_NEW"
    elif [ "$2" = "disable" ]
    then
      _warn "Disable plugin '$3'" 'Plugin'
      OMS_PLUGIN_NEW="$3"
      sed -n "/OMS_PLUGIN=(/p" "$HOME/.profile" | sed "s/\"$OMS_PLUGIN_NEW\" //g" "$HOME/.profile" > "$OMS_CACHE/profile"
      mv "$OMS_CACHE/profile" "$HOME/.profile"
      _warn "Disabled. It will be applied after you restart."
    fi
  elif [ "$1" = "--pluginlist" ]
  then
    _info "You are using these plugins:"
    echo "${OMS_PLUGIN[@]}"
    echo ' List of plugins:'
    ls "$OMS_DIR/usr/plugin"
    _warn "The option \"--pluginlist\" has already expired. Use \"oms -p list\""
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
  elif [ "$1" = "-e" ] || [ "$1" = "--advconfig" ]
  then
    if [ -z "$2" ]
    then
      vi "$OMS_CACHE/config.ohmysh.sh"
    else
      $2 "$OMS_CACHE/config.ohmysh.sh"
    fi
  elif [ "$1" = "--chsh" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'CLI' '7'
      _helpcommand
    else
      _warn "Changing your shell to $2" "CLI"
      if [ "$2" = "sh" ] || [ "$2" = "/bin/sh" ]
      then
        echo '. ~/.profile' >> ~/.bashrc
      else
	      echo "OMS_OTHER_SHELL='$2'" >> "$HOME/.$2rc"
        echo '. ~/.profile' >> "$HOME/.$2rc"
      fi
    fi
  elif [ "$1" = "-r" ] || [ "$1" = "--reload" ]
  then
    oms_reload
  elif [ "$1" = "--channel" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'CLI' '7'
      _helpcommand
    else
      case "${2}" in
        "stable"|"main")
          _oms_update_channel "main"
          ;;
        "dev")
          _oms_update_channel "dev"
          ;;
        *)
          ;;
      esac
    fi
  elif [ "$1" = "--debug" ]
  then
    if [ -z "$2" ]
    then
      _error "Missing parameters" 'CLI' '7'
      _helpcommand
    else
      if [ "$2" = "list" ]
      then
        _debug_list
      elif [ -z "$3" ]
      then
        _debug_check "$2"
      elif [ "$3" = "on" ]
      then 
        _debug_start "$2"
      elif [ "$3" = "off" ]
      then
        _debug_stop "$2"
      fi
    fi
  else
    _error "Parameters '$1' not found" 'CLI' '2'
  fi
}

alias ohmysh="oms $1 $2 $3 $4"

_oms_completion()
{
    local curr prev

    COMPREPLY=()
    curr="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    pre2="${COMP_WORDS[COMP_CWORD-2]}"
#     blue "$curr $prev $pre2"

    opts="-u --update --uninstall -h --help -v --version -t --theme -p --theme -a --alias -c --cover -e --advconfig --chsh -r --reload --channel --debug"
    if [[ "${COMP_CWORD}" -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${opts}" -- "${curr}") )
    fi

    case "${prev}" in
        "-t"|"--theme")
            COMPREPLY=( $(compgen -W "list $(ls --color="never" "$OMS_DIR/usr/theme" && ls --color="never" "$OMS_DIR/usr/local/theme")" -- "${curr}") )
            ;;
        "-p"|"--plugin")
            COMPREPLY=( $(compgen -W "start enable disable list" -- "${curr}") )
            ;;
        "--chsh")
            COMPREPLY=( $(compgen -W "bash sh zsh" -- "${curr}") )
            ;;
        "--channel")
            COMPREPLY=( $(compgen -W "stable dev" -- "${curr}") )
            ;;
        "-a"|"--alias"|"-c"|"--cover"|"-e"|"--advconfig")
            COMPREPLY=( $(compgen -W "vi vim nano" -- "${curr}") )
            ;;
        "--debug")
            COMPREPLY=( $(compgen -W "list ${!_OMS_DEBUG_LIST[*]}" -- "${curr}") )
            ;;
        *)
            ;;
    esac
    case "${pre2}" in
        "-p"|"--plugin")
            case "${prev}" in
                "start"|"enable"|"disable")
                    COMPREPLY=( $(compgen -W "$(ls --color="never" "$OMS_DIR/usr/plugin" && ls --color="never" "$OMS_DIR/usr/local/plugin")" -- "${curr}") )
                    ;;
            esac
            ;;
    esac
}

complete -F _oms_completion oms

#export -f oms _helpcommand
#export ohmysh
