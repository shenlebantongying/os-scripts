#!/usr/bin/env bash

if [ -x "$(command -v nvim)" ]; then
  echo '> Set nvim as editor'
  git config --global core.editor "nvim"
elif [ -x "$(command -v vim)" ]; then
  echo '> Set vim as editor'
  git config --global core.editor "vim"
elif [ -x "$(command -v kate)" ]; then
  echo '> Set Kate as editor'
  git config --global core.editor "kate"
elif [ -x "$(command -v emacs)" ]; then
  echo '> Set emacs as editor'
  git config --global core.editor "emacs"
else
    echo "No editors found" >&2
    exit 1
fi

git config --global user.name "shenleban tongying"
git config --global user.email shenlebantongying@gmail.com

git config --list
