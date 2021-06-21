#!/usr/bin/env bash

set -e
set -x # print what was executed

if [[ -d ${HOME}/.emacs.d ]];
then
    cd "${HOME}"/.emacs.d
    git pull
else
    git clone --depth=1 https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d
fi

if [ -f /usr/bin/systemctl ];then
    systemctl --user enable emacs
fi
