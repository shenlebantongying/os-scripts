#!/bin/bash

needed="base-devel \
git"

core="firefox \
noto-fonts-cjk \
vlc \
okular \
ark \
bash-completion \
shellcheck \
qt5-tools \
akregator \
fuse
hunspell
hunspell-en_us
"

sudo pacman -S --needed "${needed}"
sudo pacman -S "${core}"
