#!/bin/bash

# OhMySh Installer

# config
if [ -z $OMS ]
then
  OMS="$HOME/.ohmysh"
fi
if [ -z $OMS_CACHE ]
then
  OMS_CACHE="$HOME/.ohmysh-cache"
fi
if [ -z $REPO ]
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
  if [ -n "$2"  ]; then
    where="::$2"
  fi
  hash $1 2>/dev/null || { echo " >> OhMySh$where : ERROR cannot found command \"$1\", please insall it!!! "; return 1; }
 return 0
}

omsconfig(){
  cat <<EOF > "$OMS_RC_D"
#
# CREATED BY OhMySh <https://github.com/ohmysh/ohmysh>
# OhMySh
#
# OhMySh work dir. Please don't edit it!
export OMS_DIR='$OMS'
export OMS_CACHE='$OMS_CACHE'

# OhMySh theme
export OMS_THEME='colorshell'
export OMS_PLUGIN=()

# OhMySh main script
source "\$OMS_DIR/main.sh"

EOF
  echo ". $OMS_RC_D" >> "$HOME/.bashrc"
}

echo ' Welcome to OhMySh installer script! '
echo '   OhMySh <https://github.com/ohmysh/ohmysh>'

# options
if [ -n "$1" ]
then
  if [ "$1" = "--config" ]
  then
    echo ' >> Config Force'
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
echo ' >> Preparing Install'
checkcommand git Installer
if [ $? == 1 ] ; then
  echo ' [ERROR 1] OhMySh::Installer : ERROR Failed to install OhMySh!!! '
  exit 1
fi
if [ -d "$OMS" ]
then
  echo ' [ERROR 2] OhMySh::Installer : You had installed OhMySh!!! '
fi
echo ' >> Getting OMS'
git clone "$REPO" "$OMS" || exit 3
echo ' >> Putting config file'
if [ "$NF" = "NEWFILE" ] ; then
  omsconfig
fi
echo ' >> Creating cache'
mkdir -p "$OMS_CACHE"
date +%Y%m%d > $OMS_CACHE/update
cp "$OMS/lib/etc/alias.etc.sh" "$OMS_CACHE/alias.ohmysh.sh"
cp "$OMS/lib/etc/cover.etc.sh" "$OMS_CACHE/cover.ohmysh.sh"
cp "$OMS/lib/etc/config.etc.sh" "$OMS_CACHE/config.ohmysh.sh"
mkdir -p "$OMS_CACHE/runtime-script"
mkdir -p "$OMS_CACHE/startup-script"

echo ' OhMySh is already installed! '

# config
echo ' Configing... '
echo ' >> Checking shell'

echo " [INFO] Your shell is $SHELL"
echo ' [INFO] If your shell is not /bin/sh or /bin/bash,'
echo ' [INFO]   you may need to run the following scrip.'
echo ' [INFO]     > $ chsh -s /bin/bash'
echo ' [INFO] '

source "$OMS/lib/logo.sh"
_logo
cat <<EOF
  Welcome to use OhMySh!
    OhMySh official Documents is https://ohmysh.github.io/docs-v2
    OhMySh official GitHub Repo is ohmysh/ohmysh <https://github.com/ohmysh/ohmysh>
  About configure:
    View our docs: https://ohmysh.github.io/docs-v2
    Or Chinese:    https://ohmysh.gitee.io/docs-v2
EOF

source "$OMS/lib/ohmysh-version.sh"
echo " Installed OhMySh Version $OMS_VER!"

# OhMySh Installer Script.

