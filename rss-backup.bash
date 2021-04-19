#!/usr/bin/env bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

cp ~/.local/share/akregator/data/feeds.opml $SCRIPTPATH/rss.opml
