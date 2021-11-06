#!/usr/bin/env bash

set -e
function green-msg(){ 
    echo -e "\e[0;32m[slb] $1\e[0m"
}

# ack -> check command exist
if command -v racket &> /dev/null
then
    green-msg "Racked already installed :)"
    exit 0
fi

OSNAME=$(awk -F= '/^NAME/{gsub(/"/, "", $2);print $2}' /etc/os-release)

#TODO: change this to case?
for i in "KDE neon" "Ubuntu"
do
    if [ "$i" == "$OSNAME" ]
    then
        C_OSNAME="ubuntu"
        break 
    fi
done

for i in "Arch Linux"
do
    if [ "$i" == "$OSNAME" ]
    then
        C_OSNAME="archlinux"
        break 
    fi
done

green-msg "Your os is $OSNAME -> $C_OSNAME"

# TODO: ubuntu need aspell dict
case $C_OSNAME in
    ubuntu) 
        sudo add-apt-repository ppa:plt/racket
        sudo apt-get update
        sudo apt install racket
    ;;
    archlinux)
        sudo pacman -S racket aspell-en
    ;;
esac

# ack -> check command exist
if command -v racket &> /dev/null
then
    green-msg "Racked installed :)"
    exit 0
fi