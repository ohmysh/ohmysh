#!/bin/bash
# OhMySh Optional Auto Completion
#   powered by https://github.com/scop/bash-completion
#   Bash-Completion built in support
# Usage:
#   https://github.com/scop/bash-completion#installation
#   Then, enable this in config.sh

export OMSBC_status="Stoped"
export OMSBC_path=""
export OMSBC_plat=""

if [ "$configBashcompletion" = "Enable" ]
then
    if [ "$SHELL" = '/bin/bash' ]
    then
        if [ "$(uname -s)" = 'Linux' ]
        then
            export OMSBC_plat="Linux"
            export OMSBC_path="$bashcompletionPathLinux"
            if [ -f "$bashcompletionPathLinux" ]
            then
                . "$bashcompletionPathLinux"
                export OMSBC_status="Running"
            else
                export OMSBC_status="Error 11: No such file or directory."
            fi
        else
            export OMSBC_plat="MacOS"
            export OMSBC_path="$bashcompletionPathMacOS"
            if [ -f "$bashcompletionPathMacOS" ]
            then
                . "$bashcompletionPathMacOS"
                export OMSBC_status="Running"
            else
                export OMSBC_status="Error 11: No such file or directory."
            fi
        fi
    fi
fi
