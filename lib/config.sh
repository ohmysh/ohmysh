#!/bin/bash
# OhMySH Config file reader
# Starts on Augest, 2021 Updates

if [ ! -f "$OMS_CACHE/config.ohmysh.sh" ]
then
  if [ -f "$OMS_DIR/lib/etc/config.etc.sh" ]
  then
    cp "$OMS_DIR/lib/etc/config.etc.sh" "$OMS_CACHE/config.ohmysh.sh"
  else
    touch "$OMS_CACHE/config.ohmysh.sh"
  fi
fi

##### GLOBAL SETTINGS #####
# You can not edit the settings below.
export configUpdate='Auto'
export configCover='Enable'
export configStartPath="$HOME/"
export configPathEnv='Disable'
export configBashcompletion='Enable'
export configLOLCAT='Enable'
export mapLs='Enable'
export mapCd='Enable'
export mapHelp='Enable'
export mapMSDos='Enable'
export mapCSP2021='Disable'
export mapTrash='Enable'
export trashService='Enable'
export trashAutoDeleteService='Disable'
export trashAutoDeleteConfigDate='30'
export bashcompletionPlatform='Auto'    # (Auto/Linux/MacOS/Custom)
export bashcompletionPathLinux='/usr/share/bash-completion/bash_completion'
export bashcompletionPathMacOS='/sw/etc/bash_completion'
export bashcompletionPathCustom='Custom path'
export dateFormat='%x'
export timeFormat='%H:%M:%S'
export editorSelect='vim'

##### GLOBAL DEFINES #####
# Do not edit it.
shopt -s globstar
shopt -s extglob 

##### PERSONAL SETTINGS #####
# You can edit your config under this file.
source "$OMS_CACHE/config.ohmysh.sh"
