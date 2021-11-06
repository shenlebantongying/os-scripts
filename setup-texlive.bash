#!/usr/bin/env bash

set -e

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

cd "${SCRIPTPATH}"

curl -SL https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz -o install-tl-unx.tar.gz
mkdir install_tl && tar xf install-tl-unx.tar.gz -C install_tl --strip-components 1

cd ./install_tl
sudo ./install-tl -init-from-profile ../texlive.profile

cd ../
rm ./install-tl-unx.tar.gz
rm -rf ./install_tl