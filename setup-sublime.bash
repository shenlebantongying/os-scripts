#!/usr/bin/env bash

if [ "$(pacman -Qi | grep'sublime')" ]; then
    echo "sublime already installed"
    echo "do nothing"
else
    https://www.sublimetext.com/docs/linux_repositories.html
    curl -O https://download.sublimetext.com/sublimehq-pub.gpg && sudo pacman-key --add sublimehq-pub.gpg && sudo pacman-key --lsign-key 8A8F901A && rm sublimehq-pub.gpg
    echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf
    sudo pacman -Syu sublime-text sublime-merge
fi
