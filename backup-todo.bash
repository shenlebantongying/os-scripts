#!/usr/bin/env bash

set -ex

cd "${HOME}" || exit

if [ ! -d "${HOME}"/.task ]; then
    git clone git@gitlab.com:slbtty/dotask.git .task
fi

cd .task || exit
git commit -a --allow-empty-message -m ''
git push
echo "Tasks pushed to"
git remote -v