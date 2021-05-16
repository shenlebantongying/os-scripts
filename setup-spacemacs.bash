#!/usr/bin/env bash

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

rm -rf ${HOME}/.emacs.d
git clone --depth=1 https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d

${SCRIPTPATH}/backup-emacs.sh -r