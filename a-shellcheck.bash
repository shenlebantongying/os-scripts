#!/usr/bin/env bash

for i in *;do
    # compare command with a string
    if [ "$(file --mime-type --brief "${i}")" == "text/x-shellscript" ];then
        shellcheck "${i}"
    fi
done