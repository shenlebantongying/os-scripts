#!/usr/bin/env bash
set -e

# Dependency failing, doesn't work
# https://github.com/facebook/watchman/issues/914
path="${HOME}/git-watchman"
if [[ ! -d $path ]]; then
    git clone https://github.com/facebook/watchman.git --depth 1 "${path}"
fi
cd "${path}"
./autogen.sh
./configure
make
sudo make install