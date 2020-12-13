#!/bin/sh

_OMS_PWD(){
  local __PWD=$(pwd)
  if [ "$__PWD" != "$OMS_PWD" ]; then
    OMS_PWD=$__PWD
    return 1
  fi
  return 0
}

OMS_PWD="$(pwd)"
