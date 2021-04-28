#!/usr/bin/env bash

for f in *.*
do
    chmod +x "$f"
done

# for f in *.bash
# do
#     shellcheck  -x "$f"
# done