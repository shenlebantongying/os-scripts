#!/usr/bin/env bash

source slb.bash
# NOTE: getopts is Bash/Zsh built-in
# There are shit tons of way to do this

usage() {
  cat <<EOF
Usage: 
-b backup .spacemacs
-r restore .spacemacs
EOF
  exit
}

cp-spacemacs(){
    mkdir -p "$SCRIPTPATH/home"
    cp -i ~/.spacemacs "$SCRIPTPATH/home/.spacemacs"
    if [ -f "$SCRIPTPATH/home/.spacemacs" ]
        then
            green-msg "Backed up"
        else 
            red-msg "Failed to Backup"
    fi
}

# TODO: add diff check
restore-spacemacs(){
    cp -i "$SCRIPTPATH/home/.spacemacs" ~/.spacemacs
    if [ -f "$SCRIPTPATH/home/.spacemacs" ]
        then
            green-msg "Restored"
        else 
            red-msg "Failed to restore"
    fi
}

while getopts "br" X
do
    case "$X" in
        r) restore-spacemacs ;;
        b) cp-spacemacs;;
        \?) usage ;;
    esac
    has_args="t"
done


[[ "$has_args" != "t" ]] && cp-spacemacs