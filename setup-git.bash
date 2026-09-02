#!/usr/bin/env bash

git config --global user.name "shenleban tongying"
git config --global user.email shenlebantongying@gmail.com

git config --global core.autocrlf true
git config --global core.eol lf
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

echo "------------"
echo "git config --global core.editor "emacs""
