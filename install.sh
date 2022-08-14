#!/bin/bash

# OhMySh Installer

# Color Defines
function blue(){
    echo -e "\033[34m$1\033[0m"
}
function green(){
    echo -e "\033[32m[ $1 ]\033[0m"
}
function bred(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
function byellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
_error(){
  if [ -z "$2" ]
  then
    tp="[ERROR] OhMySh"
  elif [ -z "$3" ]
  then
    tp="[ERROR] OhMySh::$2"
  else
    tp="[ERROR $3] OhMySh::$2"
  fi
  bred " $tp : $1"
}
_warn(){
  if [ -z "$2"  ]
  then
    tp="[WARNING] OhMySh"
  else
    tp="[WARNING] OhMySh::$2"
  fi
  byellow " $tp : $1"
}
_info(){
    if [ -z "$2"  ]
    then
        tp="[INFO] OhMySh"
    else
        tp="[INFO] OhMySh::$2"
    fi
    blue " $tp : $1"
}

# config
if [ -z "$OMS" ]
then
  OMS="$HOME/.ohmysh"
fi
if [ -z "$OMS_CACHE" ]
then
  OMS_CACHE="$HOME/.ohmysh-cache"
fi
if [ -z "$REPO" ]
then
  REPO="https://github.com/ohmysh/ohmysh"
fi

OMS_RC_D="$HOME/.profile"
#OMS_RC_BASH="$HOME/.bashrc"
NF="NEWFILE"

if [ -f "$HOME/.ohmysh-backup" ]
then
  NF="OLDFILE"
  mv "$HOME/.ohmysh-backup" "$OMS_RC_D"
  . "$OMS_RC_D"
  OMS="$OMS_DIR"
fi  

# lib
checkcommand(){
  hash "$1" 2>/dev/null || { _error "Cannot found command \"$1\", please insall it!!! " "Installer" "1"; return 1; }
 return 0
}

omsconfig(){
  cat <<EOF > "$OMS_RC_D"
#
# CREATED BY OhMySh <https://github.com/ohmysh/ohmysh>
# OhMySh
#

# OhMySh work dir. Please do NOT modify it!
# * Main working path
export OMS_DIR='$OMS'
# * Cache Directory
export OMS_CACHE='$OMS_CACHE'

# OhMySh theme & plugin
# * You can change themes by using 'oms -t THEME_NAME'
export OMS_THEME='colorshell'
# * You can change plugins by using 'oms -p ...'
export OMS_PLUGIN=()

# OhMySh main script
source "\$OMS_DIR/main.sh"

# OhMySh profile list defining
EOF
  echo ". $OMS_RC_D" >> "$HOME/.bashrc"
  echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> "$HOME/.bashrc"
}

blue ' Welcome to OhMySh installer script! '
blue '   OhMySh <https://github.com/ohmysh/ohmysh>'

# options
if [ -n "$1" ]
then
  if [ "$1" = "--config" ]
  then
    _info 'Config Force'
    omsconfig
  else
    cat <<EOF
                     Installer Help --- OhMySh
[OPTIONS]
    --help                           :   Get help
    --config                         :   Config only

[Advanced Settings]
    OMS=XXX ./OMSInstaller.sh        :   Change OMS install path
    OMS_CACHE=XXX ./OMSInstaller.sh  :   Change OMS Cache path
    REPO=XXX ./OMSInstaller.sh.      :   Change OMS repo

OhMySh Installer Script
EOF
  fi
  exit
fi

# install
cloneerror(){
    _error "Cannot reach OhMySh repo, check on FAQ." "Installer" "3"
}

_info 'Preparing to install'
checkcommand git Installer
if [ $? == 1 ] ; then
  _error 'Failed to install OhMySh!!! ' 'Installer' '1'
  exit 1
fi
if [ -d "$OMS" ]
then
  _error 'OhMySh has been installed on your device ' 'Installer' '2'
  exit 2
fi
_info '  Getting OMS'
git clone "$REPO" "$OMS" || ( cloneerror && exit 3 )
_info 'Putting config file'
if [ "$NF" = "NEWFILE" ] ; then
  omsconfig
fi
[ -f "$OMS/lib/opt/profile-update.sh" ] && source "$OMS/lib/opt/profile-update.sh"
_info '  Creating cache'
mkdir -p "$OMS_CACHE"
date +%Y%m%d > "$OMS_CACHE/update"
cp "$OMS/lib/etc/alias.etc.sh" "$OMS_CACHE/alias.ohmysh.sh"
cp "$OMS/lib/etc/cover.etc.sh" "$OMS_CACHE/cover.ohmysh.sh"
cp "$OMS/lib/etc/config.etc.sh" "$OMS_CACHE/config.ohmysh.sh"
mkdir -p "$OMS_CACHE/runtime-script"
mkdir -p "$OMS_CACHE/startup-script"
mkdir -p "$OMS_CACHE/trash"

# install lolcat with apt-get if not found
if [ ! -f "$OMS/lib/bin/lolcat" ]
then
  _info '  Installing lolcat'
  sudo apt-get install lolcat
fi

_info 'OhMySh is already installed! '

# config
_info 'Configing... '
_info '  Checking shell'

# shell info
cat <<EOF
 [INFO] Your shell is $SHELL
 [INFO] If your shell is not /bin/sh or /bin/bash,
 [INFO]   you may need to run the following script.
 [INFO]     > # chsh -s /bin/bash
 [INFO] 
EOF

# logo
source "$OMS/lib/logo.sh"
_logo
cat <<EOF
  Welcome to use OhMySh!
    OhMySh official documents - https://ohmysh.github.io/docs-v2
    OhMySh official GitHub Repo - ohmysh/ohmysh <https://github.com/ohmysh/ohmysh>
  About configuring:
    Visit our docs: https://ohmysh.github.io/docs-v2
    Or Chinese:     https://ohmysh.gitee.io/docs-v2
EOF

source "$OMS/lib/ohmysh-version.sh"
_info "Installed OhMySh Version $OMS_VER!"

# OhMySh Installer Script.

