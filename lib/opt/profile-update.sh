#!/bin/bash

# This script is for OhMySh to update its profile list.

_info "- Creating profile list..."

[ -f "$HOME/.bashrc" ] && echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> ~/.bashrc
[ -f "$HOME/.profile" ] && echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> ~/.profile
[ -f "$HOME/.zshrc" ] && echo "OMS_PROFILE+=(\"\${BASH_SOURCE[0]}\")" >> ~/.zshrc
# Other supports need your help!
