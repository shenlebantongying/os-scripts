export LANG=en_US.UTF-8

case `uname` in
    Darwin)
    # commands for OS X go here
    ;;
    Linux)
        path=(
            $HOME/s
            $HOME/scripts
            $HOME/bin
            $HOME/.local/bin
            $path
        )

        plugins+=(archlinux)

    ;;
    *)
    echo Path not set, cuz no idea about sys
  ;;
esac

export PATH


# zsh itself
HISTSIZE=10000
SAVEHIST=10000
setopt histignoredups


# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# User configuration

cdpath=($HOME / ..)
if [ -e /home/slbtty/.nix-profile/etc/profile.d/nix.sh ]; then . /home/slbtty/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
