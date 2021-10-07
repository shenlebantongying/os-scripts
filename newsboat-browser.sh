#!/usr/bin/env bash

if command -v xdg-open &> /dev/null
then
    xdg-open "$@" &
elif command -v open &> /dev/null
then
    open "$@" &
elif command -v firefox &> /dev/null
then
    firefox "$@" &
elif command -v firefox-developer-edition &> /dev/null
then
    firefox-developer-edition "$@" &
fi

