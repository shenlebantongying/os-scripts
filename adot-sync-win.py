from adot import init, sync

init("~/os-scripts/home")

sync("~/Documents/PowerShell/Microsoft.PowerShell_profile.ps1")

sync("~/.gitignore_global")

# add ~ as HOME to env var
sync("~/.emacs.d/init.el")
sync("~/.emacs.d/early-init.el")
sync("~/.emacs.d/user-lisp/*.el")
