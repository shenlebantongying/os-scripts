#!/usr/bin/env bash
SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

# Old Akregator
# cp ~/.local/share/akregator/data/feeds.opml "$SCRIPTPATH"/rss.opml

# Diff will stop bash execuation folw, check `man diff`
diff ~/.newsboat/urls "${SCRIPTPATH}"/rss.urls && echo "no new urls" || echo "=[New Urls]="

if [[ -f "${SCRIPTPATH}"/home/.newsboat/urls ]]; then

    if [[ $(uname -m) == 'arm64' ]]; then
        /opt/homebrew/share/doc/newsboat/contrib/exportOPMLWithTags.py ~/.newsboat/urls > "${SCRIPTPATH}"/rss.opml
    else
        /usr/share/doc/newsboat/contrib/exportOPMLWithTags.py ~/.newsboat/urls > "${SCRIPTPATH}"/rss.opml
    fi
fi

echo "OK"