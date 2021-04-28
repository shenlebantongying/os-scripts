#!/usr/bin/env bash

# disable windows, win, Super_L, Hyper, Mac, Start key
kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""

# disable all lock screen keys (including hype + L to input Lambda)
kwriteconfig5 --file kglobalshortcutsrc --group ksmserver --key "Lock Session" ",,Lock Session"
qdbus org.kde.KWin /KWin reconfigure
