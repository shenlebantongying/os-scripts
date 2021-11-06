#!/usr/bin/env bash

# disable windows, win, Super_L, Hyper, Mac, Start key
kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""

# disable all lock screen keys (including hype + L to input Lambda)
kwriteconfig5 --file kglobalshortcutsrc --group ksmserver --key "Lock Session" "none,Meta+L\tCtrl+Alt+L\tScreensaver,Lock Session"
# i need meta+wasd-qe
kwriteconfig5 --file kglobalshortcutsrc --group kwin --key "Show Desktop" "none,Meta+D,Show Desktop"
kwriteconfig5 --file kglobalshortcutsrc --group plasmashell --key "stop current activity" "none,Meta+S,Stop Current Activity"
kwriteconfig5 --file kglobalshortcutsrc --group plasmashell --key "manage activities" "none,Meta+Q,Show Activity Switcher"
kwriteconfig5 --file kglobalshortcutsrc --group org.kde.dolphin.desktop --key "_launch" "none,Meta+E,Dolphin"

# for unknow reason, this nowlonger works...
# qdbus org.kde.KWin /KWin reconfigure
kquitapp5 kglobalaccel && sleep 2s && kglobalaccel5 &