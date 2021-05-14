#!/usr/bin/env bash

read -r -p "[NOTICE]: remember to change the version number inside the script!"

old=9
gccv=11

oldgcc="gcc-${old}"
oldgpp="g++-${old}"

gccname="gcc-${gccv}"
gppname="g++-${gccv}"

addrepo=true

if [ true == ${addrepo} ];
then
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install gcc-${gccv} g++-${gccv}
fi

curgcc=$(basename "$(readlink -f "$(which gcc)")") # => output gcc-9 or a long complete name
curgpp=$(basename "$(readlink -f "$(which g++)")") # => output g++-9

if [ "${curgcc}" == "${gccname}" ] || [ "${curgcc}" == "x86_64-linux-gnu-gcc-${gccv}" ]; then
    echo "Already get a cutting edge ${gccname}"
    echo "To get back => sudo update-alternatives --config gcc"
    exit 0

else

# make sure a "pure" config
sudo update-alternatives --remove-all gcc 
sudo update-alternatives --remove-all g++

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/${oldgcc} 10  --slave /usr/bin/g++ g++ /usr/bin/${oldgpp}
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/${gccname} 20 --slave /usr/bin/g++ g++ /usr/bin/${gppname}

echo "==[ currnet gcc update-alternatives]================"
echo "=> gcc "
sudo update-alternatives --query gcc
echo "=> sudo update-alternatives --config gcc"

# No need to change g++ manually, since it is a "slave" of gcc
# echo "=> g++ "
# sudo update-alternatives --query g++
#echo "=> sudo sudo update-alternatives --config g++"

fi


