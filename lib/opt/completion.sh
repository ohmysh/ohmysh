#!/bin/bash

if [ "$SHELL" = '/bin/bash' ]
then
    if [ "$(uname -s)" = 'Linux' ]
    then
        [ -f "$bashcompletionPathLinux" ] && . "$bashcompletionPathLinux"
    else
        [ -f "$bashcompletionPathMacOS" ] && . "$bashcompletionPathMacOS"
    fi
fi
