#!/usr/bin/env bash

if [ -e "$HOME/.ssh/id_ed25519.pub" ]; then
    cat ~/.ssh/id_ed25519.pub
else
    ssh-keygen -t ed25519 -C "shenlebantongying@gmail.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    cat ~/.ssh/id_ed25519.pub
fi

