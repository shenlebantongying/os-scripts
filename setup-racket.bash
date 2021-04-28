#!/usr/bin/env bash
source slb.bash

if command -v racket &> /dev/null
then
    green-msg "Racked already installed :)"
    exit 0
fi

OSNAME=$(awk -F= '/^NAME/{gsub(/"/, "", $2);print $2}' /etc/os-release)

for i in "KDE neon" "Ubuntu"
do
    if [ "$i" == "$OSNAME" ]
    then
        C_OSNAME="ubuntu"
        break 
    fi
done

blue-msg "Your os is $OSNAME -> $C_OSNAME"


case $C_OSNAME in
    ubuntu) 
        sudo add-apt-repository ppa:plt/racket
        sudo apt-get update
        sudo apt install racket
    ;;
esac
