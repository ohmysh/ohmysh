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
  _info '  Installing lolcat...'
  # install lolcat with apt-get if operating system is debian/ubuntu or based on debian/ubuntu
  if [ -e "/etc/debian_version" ]
  then
    # check if is ubuntu
    if [ -e "/etc/lsb-release" ]
    then
      if grep -q "Ubuntu" "/etc/lsb-release"
      then
        # install lolcat with apt-get if snap is not installed or if snapd not running
        # so if snap is installed and snapd is running, we will use snap to install lolcat 
        if [[ -e "/usr/bin/snap " ]] && [[ -f "/usr/bin/snap" ]] && [[ -e "/usr/lib/snapd" ]] && [[ -d "/usr/lib/snapd"]]
        then
          #later ...an idea: verify if systemd have snapd running
          _info ' Snap is installed, you can installing lolcat with snap !'
          # ask if user want to install lolcat with snap

          echo -n "Proceed? [y/n]: "
          read answer
          if [[ $answer == "y" ]] || [[ $answer == "Y" ]] || [[ $answer == "yes" ]] || [[ $answer == "Yes" ]]
          then
            # install lolcat with snap if the user want to use snap
            _info '    Installing lolcat with snap'
            snap install lolcat-c
          else
            _info '  Skipping lolcat installation'
            _info '  Intalling lolcat with apt-get'
            apt-get install -y lolcat
          fi
        # else lolcat install with apt-get
        else
          apt-get install -y lolcat
        fi
      fi
    else
      apt-get install -y lolcat
    fi
  fi
  # install lolcat with yum if operating system is centos/redhat/fedora or based on centos/redhat/fedora
  if [ -e "/etc/redhat-release" ]
  then
    yum install -y lolcat
  fi
  # install lolcat with AUR if operating system is archlinux
  if [ -e "/etc/arch-release" ]
  then
    git clone https://aur.archlinux.org/packages/c-lolcat
    cd c-lolcat 
    makepkg -csi
    cd ..
    rm -rf c-lolcat
  fi
  # install lolcat with pacman if operating system is manjaro
  if [ -e "/etc/manjaro-release" ]
  then
    pacman -S --noconfirm lolcat
  fi
  # install lolcat with the command 'dnf install lolcat' using dnf if operating system is fedora
  if [ -e "/etc/fedora-release" ]
  then
    dnf install -y lolcat
  fi
  # install lolcat with apk if operating system is alpine
  if [ -e "/etc/alpine-release" ]
  then
    apk add -U --no-cache --virtual .lolcat-dev lolcat
  fi
  # install lolcat from source if operating system is other
  if [ ! -f "/etc/debian_version" ] && [ ! -f "/etc/redhat-release" ] && [ ! -f "/etc/arch-release" ] && [ ! -f "/etc/manjaro-release" ] && [ ! -f "/etc/SuSE-release" ] && [ ! -f "/etc/slackware-version" ] && [ ! -f "/etc/alpine-release" ]
  then
    _info '  Installing lolcat from source'
    git clone https://github.com/jaseg/lolcat.git
    cd lolcat
    # verify if OS is MACOS or not
    if [ -e "/usr/bin/sw_vers" ]
    then
      # put info message 'Ho an APPLE !'
      _info '  Ho an APPLE !'
      _info 'Build loclcat... (using make)'
      make && _info 'now put the resulting binary at a place of your choice.(lolcat)'
      cd ..
    else
      make && sudo make install && _info '  Installing lolcat from source done'
      cd ..
      _info '  Remove lolcat source code'
      rm -rf lolcat
    fi
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

