#!/usr/bin/env bash

# this file require GNU coreutils & newest bash

set -e

SCRIPT=$(realpath "$0") # -> Complete path /home/slbtty/scripts/sourcetest.bash
SCRIPTPATH=$(dirname "$SCRIPT") #-> only /home/slbtty/scripts

# updated color display as it doesn't supported in some systems
# https://stackoverflow.com/questions/25879183/can-terminal-app-be-made-to-respect-ansi-escape-codes

# TODO: check other nanmes for tput

function red-msg(){
      echo -e "$(tput setaf 9)$1$(tput sgr 0)"
}

function green-msg(){
      echo -e "$(tput setaf 10)$1$(tput sgr 0)"
}

function blue-msg(){
      echo -e "$(tput setaf 27)$1$(tput sgr 0)"
}

# $1 -> Path to file inside git
# $2 -> Path to system target
function link_file2(){
    homeloc="${HOME}/${1}"
    scrploc="${SCRIPTPATH}/home/${1}"
if [ ! -f "$scrploc" ];
then
    red-msg "$scrploc doesn't exist"
    blue-msg "Trying to copy it from $homeloc"
    if [ -f "$homeloc" ];
    then
        green-msg "Copying $homeloc to $scrploc"
        dirloc=$(dirname "$scrploc")
        mkdir -p "$dirloc" &&  cp "$homeloc" "$scrploc"
    else
        red-msg "$homeloc doesn't exist too!"
        return;
    fi
fi

if [ -f "$homeloc" ];
then
    # TODO: detect broken link is possible
    if [ "$(file --mime-type --brief "$1")" == "inode/symlink" ];then
        green-msg "${1} is already linked!"
        return;
    else
        blue-msg "Remove original $homeloc"
        rm "$homeloc"
    fi
else
    green-msg "No $homeloc at home"
fi
ln -sf "$scrploc" "$homeloc"
green-msg "Link ${homeloc} to ${scrploc}"
}

function link_dir(){
    # ln -s cannot create directories automatically :(
    mkdir -p "${HOME}/${1}"
}

# link everything under a folder
function link_folder(){

    lfhloc="${HOME}/${1}"
    scrploc="${SCRIPTPATH}/home/${1}"

    for FILE in "${scrploc}"*;
    do
        link_file2 "${FILE#*/*/*/*/*/}"
    done

    for FILE2 in "${lfhloc}"{*.fish,*.lua,*.el,*.md,*.og};
    do
        echo "${FILE2}"
        link_file2 "${FILE2#*/*/*/}"
    done

}

link_file2 ".zshrc"
link_file2 ".bashrc"
link_file2 ".bash_profile"
link_file2 ".tmux.conf"
link_file2 ".npmrc"

link_dir ".newsboat"
link_file2 ".newsboat/config"
link_file2 ".newsboat/urls"

link_dir ".config/ranger"
link_file2 ".config/ranger/rc.conf"
link_file2 ".config/ranger/rifle.conf"
link_file2 ".config/ranger/scope.sh"

link_dir ".config/sublime-text/Packages/User"
link_file2 ".config/sublime-text/Packages/User/Preferences.sublime-settings"
link_file2 ".config/sublime-text/Packages/User/Package Control.sublime-settings"
link_file2 ".config/sublime-text/Packages/User/Terminus.sublime-settings"

#lisp related
link_file2 ".sbclrc"

#editors
link_dir ".doom.d"
link_file2 ".doom.d/init.el"
link_file2 ".doom.d/config.el"
link_file2 ".doom.d/+prog.el"
link_file2 ".doom.d/packages.el"
link_file2 ".doom.d/templates"

link_dir ".doom.d/modules/private/racketgit"
link_folder ".doom.d/modules/private/racketgit/"

link_dir ".doom.d/modules/private/proofgeneral"
link_folder ".doom.d/modules/private/proofgeneral/"

# alternative
link_dir ".spacemacs.d"
link_file2 ".spacemacs.d/init.el"

link_file2 ".vimrc"

link_dir ".config/nvim"
link_file2 ".config/nvim/init.vim"
link_dir ".config/nvim/colors"
link_file2  ".config/nvim/colors/dichromatic.vim"

# lua version of nvim doesn't have enough doc to quickly do config
#link_file2 ".config/nvim/init.lua"
#link_file2 ".config/nvim/ginit.vim"

#kakoune & halix
link_dir ".config/kak"
link_file2 ".config/kak/kakrc"
link_dir ".config/helix"
link_file2 ".config/helix/config.toml"

link_dir ".config/kak/autoload"
link_file2 ".config/kak/autoload/racket.kak"

#coqide
link_dir ".config/coq"
link_file2 ".config/coq/coqiderc"
link_file2 ".config/coq/coqide.keys"


#fish
link_dir ".config/fish"
link_file2 ".config/fish/config.fish"

link_dir ".config/fish/functions"
# loop throught all files under fish/functions, and strip first a few parts.
link_folder ".config/fish/functions/"

# hammerspoon
link_dir ".hammerspoon"
# loop throught all files under fish/functions, and strip first a few parts.
link_folder ".hammerspoon/"

link_file2 ".guile"
link_file2 ".taskrc"

#kate
link_dir ".local/share/org.kde.syntax-highlighting/themes"
link_file2 ".local/share/org.kde.syntax-highlighting/themes/Monochrome.theme"

#kitty
link_dir ".config/kitty/"
link_file2 ".config/kitty/kitty.conf"
touch ~/.config/kitty/local.conf

#kate
link_dir ".config/kate/externaltools"
link_file2 ".config/kate/externaltools/xdg-open"
link_file2 ".config/kate/externaltools/googlesearch"

#ocaml
link_dir ".config/utop"
link_file2 ".config/utop/init.ml"
