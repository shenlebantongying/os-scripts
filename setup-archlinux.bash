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
fuse\
hunspell\
hunspell-en_us\
newsboat
"

utl="fzf\
ack\
ncdu\
"


sudo pacman -S --needed "${needed}"
sudo pacman -S "${core}"

#fonts

sudo pacman -S ttf-roboto
