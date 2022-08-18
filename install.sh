#!/bin/bash

# OhMySh Installer


# function to install with the appropriate package manager from debian or ubuntu or archlinux or redhat 
linux_install_with_package_manager() {
  # if the OS is debian/ubuntu use apt-get to install $1
    if [ -f /etc/debian_version ]; then
        sudo apt-get install -y $1
    # elif the OS is archlinux use pacman to install $1
    elif [ -f /etc/arch-release ]; then
        sudo pacman -S --noconfirm $1
    # elif the OS is redhat/fedora use yum to install $1
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y $1
    else
        echo "OS not supported"
        exit 1
    fi
}

# function to update an package manager from debian or arch or redhat
linux_update_package_manager(){
    if [ -f /etc/debian_version ]; then
        sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
    elif [ -f /etc/arch-release ]; then
        sudo pacman -Syu
    elif [ -f /etc/redhat-release ]; then
        sudo yum update
    else
        echo "OS not supported"
        exit 1
    fi
}

# Check if lolcat is installed
check_lolcat_is_installed(){
  if [[ "$(which lolcat | wc -l)" != "0" ]]
  then
    return 1
  else
    return 0
  fi
}

# use check_lolcat_is_installed function to check if lolcat is installed
# if lolcat is installed display the text 'lolcat is installed' in rainbow color with an delay of 3 seconds
if [ "$(check_lolcat_is_installed)" = "1" ]
then
  echo "lolcat is installed" | lolcat -a -d 3
else
  echo "lolcat is not installed.\nDo You Want Install lolcat? (y/n)"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ] || [ "$answer" = "yes" ] || [ "$answer" = "Yes" ]
  then
    echo "Installing lolcat"
    # here use linux_update_package_manager to update the appropriate package manager
    linux_update_package_manager
    # here use linux_install_with_package_manager to install lolcat
    linux_install_with_package_manager lolcat
    echo "lolcat is installed" | lolcat -a -d 3
  else
    echo "Aborting installation of lolcat.\nYou can install lolcat manually if you want to use it(rainbow colors feature)."
  fi
fi

# function to display logo of the install
_logo_display_installer(){
cat <<EOF

      ___           ___                    ___           ___                    ___           ___              
     /\  \         /\__\                  /\__\         |\__\                  /\  \         /\__\             
    /::\  \       /:/  /                 /::|  |        |:|  |                /::\  \       /:/  /             
   /:/\:\  \     /:/__/                 /:|:|  |        |:|  |               /:/\ \  \     /:/__/              
  /:/  \:\  \   /::\  \ ___            /:/|:|__|__      |:|__|__            _\:\~\ \  \   /::\  \ ___          
 /:/__/ \:\__\ /:/\:\  /\__\          /:/ |::::\__\     /::::\__\          /\ \:\ \ \__\ /:/\:\  /\__\         
 \:\  \ /:/  / \/__\:\/:/  /          \/__/~~/:/  /    /:/~~/~             \:\ \:\ \/__/ \/__\:\/:/  /         
  \:\  /:/  /       \::/  /                 /:/  /    /:/  /                \:\ \:\__\        \::/  /          
   \:\/:/  /        /:/  /                 /:/  /     \/__/                  \:\/:/  /        /:/  /           
    \::/  /        /:/  /                 /:/  /                              \::/  /        /:/  /            
     \/__/         \/__/                  \/__/                                \/__/         \/__/             

EOF
}

_logo_installer(){
  if [ "$(checkcmd lolcat)" = "1" ]
  then
    # play an sound wav file in the folder /install/sounds
    #play /install/sounds/ohmysh.wav
    # display logo in rainbow color during 10 seconds step by step with lolcat
    _logo_display_installer | lolcat -a -d 10

  else
    _logo_display_installer
  fi

  cat <<EOF
       INSTALL OF ...
       OhMySh - The Shell Framework 
EOF
}

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

checkcmd(){
    if command -v "${1%% *}" >/dev/null 2>&1; then 
        echo '1' 
    else 
        echo -e "\033[31mCommand Not Found!\033[0m" >&2
    fi
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

_info "Update package manager"
linux_update_package_manager

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

