#!/usr/bin/env bash

set -e

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

# Old Akregator
# cp ~/.local/share/akregator/data/feeds.opml "$SCRIPTPATH"/rss.opml

cp ~/.newsboat/urls ${SCRIPTPATH}/rss.urls
/usr/share/doc/newsboat/contrib/exportOPMLWithTags.py ~/.newsboat/urls > ${SCRIPTPATH}/rss.opml

echo "OK"