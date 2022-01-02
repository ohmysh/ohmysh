#!/bin/bash

# OhMySh Core Re-Map

## Map
if [ "$mapLs" != 'Disable' ]
then
    alias ls='ls --color'
    alias ll='ls -l'
fi
if [ "$mapHelp" != 'Disable' ]
then
    alias help='oms --help'
fi
if [ "$mapMSDos" != 'Disable' ]
then
    alias cls='clear'
    alias dir='ls --color'
    alias fc='diff'
    alias erase='rm'
    alias tree='ls -R'
fi

## CSP 2021 S
if [ "$mapCSP2021" != 'Disable' ]
then
alias all-f='all'
alias all='_oms_all'
_oms_all(){
cat <<EOF
You entered the command 'all', this command does not exist. If you want to force this command, use 'all-force'.

Do you know NOI-CSP? In the 2021 exam mentioned above, the first question is
Which of the following commands is a command to view files and subdirectories within a directory?
A. ls    B. cd    C. cp    D. all
The answer is A.

'all' does not exist and the user is expected to remember ls as the correct command.
EOF
}
fi


if [ "$mapCd" != 'Disable' ] && [ "$(checkcmd 'shopt --help')" = "1" ]
then
    shopt -s autocd
fi

if [ "$mapTrash" != 'Disable' ]
then
    alias del='trash'
    alias rmt='rmtrash'
    alias lst='lstrash'
    alias ret='retrash'
    alias rma='rmtrash -a'
fi

