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

git config --global core.autocrlf input
git config --global init.defaultBranch main

git config --global alias.nocommit 'commit -a --allow-empty-message -m ""'
git config --global core.pager cat

git config --list

git config --global core.excludesfile ~/.gitignore_global


# signing 

git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global gpg.ssh.allowedSignersFile 

fsigners=~/.ssh/allowed_signers
if ! [ -e "$fsigners" ] ; then
    touch "$fsigners"
    echo "$(git config --get user.email) namespaces=\"git\" $(cat ~/.ssh/id_ed25519.pub)" >> $fsigners
fi


