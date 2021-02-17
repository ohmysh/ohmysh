#!/bin/sh

path=$(pwd)

mkdir test/cache

cat <<EOF > "$path/.oms"
#
# CREATED BY OhMySh <https://github.com/ohmysh/ohmysh>
# OhMySh
#
# OhMySh work dir. Please don't edit it!
OMS_DIR='$path'
OMS_CACHE='$path/test/cache'
# OhMySh theme
OMS_THEME='colorshell'
OMS_PLUGIN=()
# OhMySh main script
source "\$OMS_DIR/main.sh"
EOF
