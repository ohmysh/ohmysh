_plugin_runner(){
  local plug=$1
  if [ -f "$OMS_DIR/usr/plugin/$plug/$plug.plugin.sh" ]
  then
    source "$OMS_DIR/usr/plugin/$plug/$plug.plugin.sh"
  else
    _error "Cannot run plugin '$plug'" 'OhMySh' '2'
  fi
}
