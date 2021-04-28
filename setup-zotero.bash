#!/usr/bin/env bash


# TODO: automatically get the file name via Curl?
curl -L  'https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64' --output zotero.tar.bz2

tar -xvf ./zotero.tar.bz2 -C "$HOME/bin"

~/bin/Zotero_linux-x86_64/set_launcher_icon

rm -f ~/.local/share/applications/zotero.desktop

ln -s ~/bin/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop

rm -f ./zotero.tar.bz2
