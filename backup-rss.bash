#!/usr/bin/env bash
SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

echo "!!!! require sdiff 3.X"

# Old Akregator
# cp ~/.local/share/akregator/data/feeds.opml "$SCRIPTPATH"/rss.opml

# Diff will stop bash execuation folw, check `man diff`
diff ~/.newsboat/urls "${SCRIPTPATH}"/rss.urls && echo "no new urls" || echo "=[New Urls]="

if [[ -f ~/.newsboat/urls ]]; then
    sdiff ~/.newsboat/urls "${SCRIPTPATH}"/rss.urls -o ~/.newsboat/urls_temp
    cp -i ~/.newsboat/urls_temp ~/.newsboat/urls 
    cp -i ~/.newsboat/urls_temp "${SCRIPTPATH}"/rss.urls
    rm ~/.newsboat/urls_temp

    if [[ $(uname -m) == 'arm64' ]]; then
        /opt/homebrew/share/doc/newsboat/contrib/exportOPMLWithTags.py ~/.newsboat/urls > "${SCRIPTPATH}"/rss.opml
    else
        /usr/share/doc/newsboat/contrib/exportOPMLWithTags.py ~/.newsboat/urls > "${SCRIPTPATH}"/rss.opml
    fi
else 
    cp "${SCRIPTPATH}"/rss.urls ~/.newsboat/urls 
fi

echo "OK"