#!/usr/bin/env bash

set -x

cd ~ || exit
mkdir -p src
cd ./src/ || exit

if [[ -d ./ChezScheme ]];
then
    cd ./ChezScheme || exit
    git pull
else
    git clone --depth=1 git@github.com:racket/ChezScheme.git
    cd ./ChezScheme || exit
    git submodule init
fi

git submodule update
./configure --pb --installprefix=/usr/local --installschemename=chez --installscriptname=chez-script
make
sudo make install 

# # FUCK CHEZ

# sudo mv /usr/bin/scheme-script /usr/bin/chez-script
# sudo rm -f /usr/bin/scheme-script
# cd /usr/lib/csv*/a6le || exit

# # WTF? They are same!
# sudo rm -f chez.boot scheme-script.boot chez-scheme.boot
# sudo ln -s scheme.boot chez.boot
# sudo ln -s scheme.boot chez-scheme.boot
# sudo ln -s scheme.boot scheme-script.boot

echo -e "\e[31m Chez install success :) \e[0m"
