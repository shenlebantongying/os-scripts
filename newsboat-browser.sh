#!/usr/bin/env bash

if command -v firefox &> /dev/null
then
    firefox "$@" &
elif command -v firefox-developer-edition &> /dev/null
then
    firefox-developer-edition "$@" &
fi
