#!/usr/bin/env python3
import platform

from adot import *

MACOS: bool = platform.system() == "Darwin"
LINUX: bool = platform.system() == "Linux"

init()

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

# Spell Checkers
# enchant + aspell
sync("~/.config/enchant/*.dic")

if MACOS:
    sync_file_to(
        "~/.config/harper-ls/dictionary.txt",
        "~/Library/Application Support/harper-ls/dictionary.txt",
    )
elif LINUX:
    sync("~/.config/harper-ls/dictionary.txt")

# macOS
if MACOS:
    sync("~/Library/Scripts/*")
    sync("~/Library/Script Libraries/*")
    sync("~/.hammerspoon/**/*.lua")

# Wayland
if LINUX:
    sync("~/.config/niri/config.kdl")
    sync("~/.config/mako/config")
    sync("~/.config/waybar/config.jsonc")
    sync("~/.config/foot/foot.ini")
    sync("~/.config/nushell/config.nu")
