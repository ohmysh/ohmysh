#!/bin/bash

# OhMySh Core Re-Map

## Map
alias ls='ls --color'
alias help='oms --help'

if [ "$(checkcmd 'shopt --help')" = "1" ]
then
    shopt -s autocd
fi


