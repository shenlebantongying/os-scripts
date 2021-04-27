#!/usr/bin/env bash

cd ~
mkdir -p src
cd ./src/

if [[ -d ./ChezScheme ]];
then
    cd ./ChezScheme
    git pull
else
    git clone --depth=1 git@github.com:cisco/ChezScheme.git
    cd ./ChezScheme
fi

./configure
make
sudo make install

echo -e "\e[31m Chez install success :) \e[0m"

/bin/scheme