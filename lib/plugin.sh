#!/bin/bash

_plugin_runner(){
  local plug=$1
  if [ -f "$OMS_DIR/usr/plugin/$plug/$plug.plugin.sh" ]
  then
    source "${OMS_DIR}/usr/plugin/${plug}/${plug}.plugin.sh"
  elif [ -f "$OMS_DIR/usr/local/plugin/$plug/$plug.plugin.sh" ]
  then
    source "${OMS_DIR}/usr/local/plugin/${plug}/${plug}.plugin.sh"
  else
    _error "Cannot run plugin '$plug'" 'Plugin' '5'
  fi
}
