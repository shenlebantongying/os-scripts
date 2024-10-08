#!/usr/bin/env bash
set -e

function blue-msg()
{
  echo -e "\e[0;34m[git] $1\e[0m"
}

for mydir in "${HOME}"/*/; 
do
    if [[ -d  "${mydir}.git" ]]; 
    then
        cd "${mydir}"
        blue-msg "$(pwd)"
        git status . --porcelain
    fi
done
