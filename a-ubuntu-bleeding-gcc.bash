#!/usr/bin/env bash

gccv=11
gccname="gcc-${gccv}"
gppname="g++-${gccv}"

sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-${gccv} g++-${gccv}

curgcc=$(readlink "$(which gcc)") # => output gcc-9
curgpp=$(readlink "$(which gcc)") # => output g++-9

if [ "${curgcc}" == "${gccname}" ];then
    echo "Already get a cutting edge ${gccname}"
    exit 0
else

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/${curgcc} 10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/${gccname} 20
echo "what"
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/${curgpp} 10
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/${gppname} 20

echo "==[ currnet gcc update-alternatives]================"
echo "=> gcc "
sudo update-alternatives --query gcc
echo ""
echo "=> g++ "
sudo update-alternatives --query g++

# TODO: use the slave option of update-alternatives to switch them automatically
echo "=> sudo update-alternatives --config gcc"
echo "=> sudo sudo update-alternatives --config g++"
fi


