#!/usr/bin/env bash

SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname $SCRIPT)

while read -r x; do
  # ${x#"~/"}" is to remove prefix
  # ${parameter#word}
  # ${parameter/pattern/string} replace pattern with string
  # https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html

  diff -u "${x/\~/$HOME}" "${SCRIPTPATH}/dots/${x#"~/"}"
done < filelist.txt