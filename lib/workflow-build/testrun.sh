#!/bin/bash

export _path=$(pwd)

mkdir -p test/cache

bash lib/whatshell.sh
echo $_path

export OMS_DIR="$_path"
export OMS_CACHE="$_path/test/cache"
export OMS_THEME='colorshell'
export OMS_PLUGIN=('helloworld' )
#source "$OMS_DIR/main.sh"
bash -v "$OMS_DIR/main.sh"

help
oms -v
echo "$PS1"

