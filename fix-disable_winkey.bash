 #!/usr/bin/env bash

 # disable windows, win, Super_L, Hyper, Mac, Start key

kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""
qdbus org.kde.KWin /KWin reconfigure
