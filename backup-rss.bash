#!/usr/bin/env bash

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

cp ~/.local/share/akregator/data/feeds.opml "$SCRIPTPATH"/rss.opml
