#!/usr/bin/env bash

set -e

if [[ ! -d ~/common-lisp/ ]]; then
mkdir ~/common-lisp/
fi

cd ~/common-lisp/

echo "Installing armory..."
git clone https://gitlab.common-lisp.net/alexandria/alexandria.git
