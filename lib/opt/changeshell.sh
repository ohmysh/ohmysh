#!/bin/bash

. "$OMS_DIR/lib/color.sh"

# Shell changing application provides you a method to use other shell.

_yourshell="$SHELL"
_avilshell_temp="$(grep "/" /etc/shells)"
_avilshell=( ${_avilshell_temp//$'\n'/ } )

_info "You are using shell \"$_yourshell\"."
_info "Here are some shells that you can use:"

_id=0
for i in "${_avilshell[@]}"
do
    echo " [$_id] $i"
    ((_id=_id+1))
done
echo " [$_id] Custom..."

echo "Choose one from the list."
echo "* If you are using macOS and want to change to bash, you need to choose custom and input the path by yourself."
echo -n "Input [0-$_id/]: "
read number
until
    [ "$number" -ge "0" ] && [ "$number" -le "$_id" ]
do
    echo " "
    echo "Invalid input."
    echo -n "Input [0-$_id/]: "
    read number
done
echo " "

if [ "$number" = "$_id" ]
then
    echo -n "Input custom path: "
    read cpath
    until
        [ -f "$cpath" ]
    do
        echo " "
        echo "Cannot reach the target. Input again."
        echo -n "Input custom path: "
        read cpath
    done
fi

if [ -z "$cpath" ] 
then
    cpath="${_avilshell[$number]}"
fi

_log "You chose \"$cpath\"."

_warn "Are you sure to change to \"$cpath\"? [y/n]"
read -n1 ch
echo " "
if [ "$ch" = "Y" ] || [ "$ch" = "y" ]
then
    _info "Changing to \"$cpath\"..."
    sudo chsh -s "$cpath" || ( _error "Failed." && exit 1 )
    _info "Done."
    if [ -z "$(echo "$cpath" | grep bash)" ]
    then
        echo '. ~/.profile' >> "~/.bashrc"
        echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> "~/.bashrc"
    elif [ -z "$(echo "$cpath" | grep zsh)" ]
    then
        echo '. ~/.profile' >> "~/.zshrc"
        echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> "~/.zshrc"
    else
        echo "What is your profile path of your shell, like .bashrc ."
        echo -n "Input: ~/"
        read propath
        echo '. ~/.profile' >> "~/$propath"
        echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> "~/$propath"
    fi
    _info "Done."
else
    _info 'You chose No.'
fi

