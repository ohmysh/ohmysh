#!/bin/bash

_path=$(pwd)

mkdir test/cache

bash lib/whatshell.sh

OMS_DIR="$path"
OMS_CACHE="$path/test/cache"
OMS_THEME='colorshell'
OMS_PLUGIN=('helloworld' )
source "$OMS_DIR/main.sh"


echo "$PS1"
