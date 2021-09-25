#!/bin/bash

# OhMySh Core Re-Map

## Map
alias ls='ls --color'
alias ll='ls -l'
alias help='oms --help'
alias cls='clear'
alias dir='ls --color'

## CSP 2021 S
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


if [ "$(checkcmd 'shopt --help')" = "1" ]
then
    shopt -s autocd
fi


