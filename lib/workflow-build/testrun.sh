#!/bin/bash

export _path="$(pwd)"

mkdir -p test/cache

bash lib/whatshell.sh
echo "$_path"

export OMS_DIR="$_path"
export OMS_CACHE="$_path/test/cache"
export OMS_THEME='colorshell'
export OMS_PLUGIN=('helloworld' )

bash -v "$OMS_DIR/main.sh"
source "$OMS_DIR/main.sh"

echo "OMS Finished!"

oms -v
oms -h
echo "$PS1"

