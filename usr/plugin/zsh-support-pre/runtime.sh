#!/bin/bash

# Plugin Runtime script

#PROMPT=$(echo $PS1 | sed 's/\\/%/g')

_FROM=(
'\\d'
'\\D'
'\\h'
'\\H'
'\\j'
'\\l'
'\\t'
'\\T'
'\\@'
'\\A'
'\\u'
'\\w'
'\\W'
'\\!'
'\\$'
'\\['
'\\]'
)

_TO=(
'%D'
'%D'
'%m'
'%M'
'%j'
'%l'
'%*'
'%t'
'%@'
'%T'
'%n'
'%~'
'%c'
'%!'
'%#'
'%('
'%)'
)

_TPS1="$PS1"
echo $_TPS1

for ((i=0;i<=${#_FROM[@]};i++))
do
    echo -n ${_FROM[$i]} ${_TO[$i]}
    _TPS1=$(echo "$_TPS1" | sed "s/${_FROM[$i]}/${_TO[$i]}/g")
    echo $_TPS1
done

PROMPT="$_TPS1"

