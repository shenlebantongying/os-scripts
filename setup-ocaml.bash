#!/usr/bin/env bash

set -e # aborb when fail

OSNAME=$(awk -F= '/^NAME/{gsub(/"/, "", $2);print $2}' /etc/os-release)

if [ "Arch Linux" == "$OSNAME" ];
then
    sudo pacman -S unzip bubblewrap
fi


sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)

opam init
eval $(opam env)

opam install merlin utop ocp-indent ocamlformat
