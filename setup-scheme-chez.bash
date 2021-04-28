#!/usr/bin/env bash

cd ~ || exit
mkdir -p src
cd ./src/ || exit

if [[ -d ./ChezScheme ]];
then
    cd ./ChezScheme || exit
    git pull
else
    git clone --depth=1 git@github.com:cisco/ChezScheme.git
    cd ./ChezScheme || exit
fi

./configure
make
sudo make install

echo -e "\e[31m Chez install success :) \e[0m"

/bin/scheme