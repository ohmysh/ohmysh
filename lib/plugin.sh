#!/bin/bash

_plugin_runner(){
  local plug=$1
  if [ -f "$OMS_DIR/usr/plugin/$plug/$plug.plugin.sh" ]
  then
    [ -n "$_DEBUG_PLUGIN" ] && _debug "Starting plugin $plug from official package." "Plugin"
    [ -n "$_DEBUG_PLUGIN" ] && cat "${OMS_DIR}/usr/plugin/${plug}/${plug}.plugin.sh"
    [ -n "$_DEBUG_PLUGIN" ] && echo " ----------------------- "
    source "${OMS_DIR}/usr/plugin/${plug}/${plug}.plugin.sh"
  elif [ -f "$OMS_DIR/usr/local/plugin/$plug/$plug.plugin.sh" ]
  then
    [ -n "$_DEBUG_PLUGIN" ] && _debug "Starting plugin $plug from local package." "Plugin"
    [ -n "$_DEBUG_PLUGIN" ] && cat "${OMS_DIR}/usr/local/plugin/${plug}/${plug}.plugin.sh"
    [ -n "$_DEBUG_PLUGIN" ] && echo " ----------------------- "
    source "${OMS_DIR}/usr/local/plugin/${plug}/${plug}.plugin.sh"
  else
    [ -n "$_DEBUG_PLUGIN" ] && _debug "Plugin $plug cannot be found." "Plugin"
    _error "Cannot run plugin '$plug'" 'Plugin' '5'
  fi
}
