#!/usr/bin/env bash
set -e

# tcl "std" library
dir="${HOME}"/git-tcllib

if [[ ! -d ${dir} ]]; then
    git clone --depth=1 git@github.com:tcltk/tcllib.git
    cd dir
else 
    git pull 
fi

sudo wish "${dir}/installer.tcl"