#!/usr/bin/env bash

read -p "Need github token stored in T7!" CONT
if [ "$CONT" = "y" ]; then
~/script/a-github-org-repo-lists.py | xargs -n1 git clone
else
  echo "exit";
fi
