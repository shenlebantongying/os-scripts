#!/bin/bash
set -e

function _color_echo()
{
  echo -e "\e[0;$1m[slb] $2\e[0m"
}

function red-msg(){ 
    _color_echo "31" "$1";
}

function green-msg(){ 
_color_echo "32" "$1";
}

function blue-msg(){ 
_color_echo "34" "$1";
}

for mydir in "${HOME}"/*/; 
do
    if [[ -d  "${mydir}.git" ]]; 
    then
        cd "${mydir}"
        green-msg "$(pwd)"
        git status . --porcelain
    fi
done