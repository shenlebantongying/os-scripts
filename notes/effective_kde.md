# KDE 奇技淫巧

# Trash-cli

kioclient5 move [FILE] trash:/

```
function krm(){
    kioclient5 move "$@" trash:/
}
```

# Guake/Yakuake -> Konsole

Ctrl-Alt-T
Ctrl-Shift-Q

# logging with notify
Notifications -> Configure -> Other applications -> Show in history
-> 'notify-send nice'

# KWin magic

Meta + H -> Hide window border

Meta+D -> Desktop -> Open doc -> Meta+D -> back to all apps

# Assign window shortcuts

-> title bar -> configure special windows -> add rules

# disable windows, win, Super_L, Hyper, Mac, Start key
kwriteconfig5 --file kwinrc --group ModifierOnlyShortcuts --key Meta ""

# disable all lock screen keys (including hype + L to input Lambda)
kwriteconfig5 --file kglobalshortcutsrc --group ksmserver --key "Lock Session" ",,Lock Session"
qdbus org.kde.KWin /KWin reconfigure

# Special short cuts

more actions -> per applications style

# custom action menu

```
~/.local/share/kservices5/ServiceMenus/svg2eps.desktop

[Desktop Entry]
Type=Service
ServiceTypes=KonqPopupMenu/Plugin
MimeType=image/svg+xml
Actions=svg2eps
X-KDE-Submenu=Convert
Icon=video

[Desktop Action svg2eps]
Name=convert svg to eps
Icon=view-refresh
Exec=inkscape -D %u --export-type=eps
```

https://develop.kde.org/docs/dolphin/service-menus/

https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-1.0.html#exec-variables


# fzf open
alias fzfopen='kde-open5 $(fzf) &> /dev/null'

