#!/usr/bin/env bash

needed="base-devel \
git"

core="firefox \
noto-fonts-cjk \
ttf-inconsolata \
vlc \
okular \
ark \
bash-completion \
shellcheck \
qt5-tools \
fuse \
hunspell \
hunspell-en_us \
newsboat \
xdg-desktop-portal-kde \
"

utl="fzf \
ack \
ncdu \
man-db \
"

# wl-copy wl-paste for future
neovim="neovim \
neovim-qt \
xclip \
xsel \
"

sudo pacman -S --needed "${needed}"
sudo pacman -S "${core}"
sudo pacman -S "${neovim}"

#fonts

sudo pacman -S ttf-roboto
