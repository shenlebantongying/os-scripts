#!/usr/bin/env bash

set -e # aborb when fail

if [[ $OSTYPE == "darwin"* ]]; then
    echo "Currently on MacOS"
elif [[ "$OSTYPE" == "linux"* ]]; then
    OSNAME=$(awk -F= '/^NAME/{gsub(/"/, "", $2);print $2}' /etc/os-release)
    if [ "Arch Linux" == "$OSNAME" ];
    then
        sudo pacman -S unzip bubblewrap
    fi
fi

if ! command -v opam &> /dev/null
then
sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)
opam init
fi

eval $(opam env)
opam install merlin utop ocp-indent ocamlformat ocaml-lsp-server 
