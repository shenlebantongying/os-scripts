#!/usr/bin/env bash

#sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)

#opam init
#eval $(opam env)

#TODO:detect possible .profile

opam install merlin utop ocp-indent ocamlformat
