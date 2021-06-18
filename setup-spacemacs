#!/usr/bin/env bash

set -e

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

function _color_echo()
{
  echo -e "\e[0;$1m [slb] $2\e[0m"
}

# Note: - maybe invlid for some shell env
function red-msg(){ 
    _color_echo "31" "$1";
}

function green-msg(){ 
_color_echo "32" "$1";
}

function blue-msg(){ 
_color_echo "34" "$1";
}

# $1 -> Path to file inside git
# $2 -> Path to system target 
function link_file(){
if [ -f "$1" ];
then
    rm "$1"
    red-msg "Remove $1"
else
    green-msg "No $1 in home"
fi
ln -s "$2" "$1"
green-msg "Linking ${2} to ${1}"
}

rm -rf ${HOME}/.emacs.d
git clone --depth=1 https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d

link_file "${HOME}/.spacemacs" "${SCRIPTPATH}/home/.spacemacs"
