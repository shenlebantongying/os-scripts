export LANG=en_US.UTF-8

ZSH_CUSTOM=$HOME/.oh-my-zsh/custom

if [ ! -d $HOME/.oh-my-zsh ]; then 
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ ! -d $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then 
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

plugins=(git
         zsh-autosuggestions
         web-search
         dirhistory # use alt + <- / -> to go back/forth
        )

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,underline"

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

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="kphoen"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"


source $ZSH/oh-my-zsh.sh

# User configuration

cdpath=($HOME / ..)
if [ -e /home/slbtty/.nix-profile/etc/profile.d/nix.sh ]; then . /home/slbtty/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
