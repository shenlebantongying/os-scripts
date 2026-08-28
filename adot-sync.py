#!/usr/bin/env python3
import platform

from adot import sync

sync("~/.config/sublime-text/Packages/User/Package Control.sublime-settings")
sync("~/.config/sublime-text/Packages/User/Preferences.sublime-settings")
sync("~/.config/sublime-text/Packages/User/Terminus.sublime-settings")
sync("~/.gitignore_global")
sync("~/.newsboat/config")
sync("~/.newsboat/urls")
sync("~/.taskrc")


# Linguistics

sync("~/.config/utop/init.ml")

sync("~/.latexmkrc")

sync("~/.guile")

sync("~/.sbclrc")

sync("~/.npmrc")

# Shells
# .zprofile are generally useless and could be empty
sync("~/.zshrc")
sync("~/.bashrc")
sync("~/.bash_profile")
sync("~/.tmux.conf")
sync("~/.config/fish/**/*.fish")
sync("~/.config/fish/functions/*.fish")
# TODO: bug -> ** wildcard may not work?

# Editors

sync("~/.emacs.d/init.el")
sync("~/.emacs.d/early-init.el")
sync("~/.emacs.d/user-lisp/*.el")

sync("~/.config/nvim/*.lua")

sync("~/.config/helix/config.toml")
sync("~/.config/helix/themes/*")

# Terminals
sync("~/.config/wezterm/wezterm.lua")
sync("~/.config/kitty/kitty.conf")

# macOS
if platform.system() == "Darwin":
    sync("~/Library/Scripts/*")
    sync("~/Library/Script Libraries/*")
    sync("~/.hammerspoon/**/*.lua")

# Wayland
if platform.system() == "Linux":
    sync("~/.config/niri/config.kdl")
    sync("~/.config/mako/config")
    sync("~/.config/waybar/config.jsonc")
    sync("~/.config/foot/foot.ini")

