#!/usr/bin/env bash

# let coursier to install everything

curl -fLo cs https://git.io/coursier-cli-"$(uname | tr LD ld)"
chmod +x cs
./cs install cs
rm cs
cat << EOF
!!!!! You may want this

cs install scala3-compiler
cs install scala3-repl
EOF


