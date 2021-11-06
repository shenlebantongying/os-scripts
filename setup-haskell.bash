#!/usr/bin/env bash
set -e
function green-msg(){ 
    echo -e "\e[0;32m[slb] $1\e[0m"
}

green-msg "Script date: Fri Jun 11 01:14:13 PM UTC 2021";

# Stack don't have useless complesxity!
curl -sSL https://get.haskellstack.org/ | sh
# ghcup for global
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
