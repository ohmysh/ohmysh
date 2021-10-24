#!/bin/bash

_path=$(pwd)

mkdir -p test/cache

bash lib/whatshell.sh
echo $_path

OMS_DIR="$_path"
OMS_CACHE="$_path/test/cache"
OMS_THEME='colorshell'
OMS_PLUGIN=('helloworld' )
source "$OMS_DIR/main.sh"

oms --help
oms -v
echo "$PS1"

