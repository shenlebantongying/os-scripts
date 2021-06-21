#!/bin/bash

function green-msg(){ 
    echo -e "\e[0;32m[c] $1\e[0m"
}

function red-msg(){ 
    echo -e "\e[0;31m[c] $1\e[0m"
}

for f in "${HOME}"/workbench-*; do
    if [[ -d "${f}/.git" ]]; then
        green-msg "${f}"
    else 
        red-msg "${f}"
    fi
done