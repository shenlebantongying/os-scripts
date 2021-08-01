# Mainly for macos, but someday i may use a BSD

HISTSIZE=10000
SAVEHIST=10000

export CLICOLOR=1 # is this suit for all BDS utils?
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# personal
path+='~/scripts'
path+='~/.emacs.d/bin'

# homebrew
path+='/usr/local/bin'
path+='/usr/local/sbin'
path+='/usr/local/smlnj/bin'
path+='/usr/local/opt/openjdk/bin'
path+='/usr/local/opt/sqlite/bin'

## GNU
path+='/usr/local/opt/coreutils/libexec/gnubin'

#????
path+='/Library/Frameworks/Mono.framework/Versions/Current/Commands'

export PATH

alias todo="code ./todo.md"

export VISUAL=vim
export EDITOR="$VISUAL"

# opam configuration
#test -r /Users/Bash/.opam/opam-init/init.zsh && . /Users/Bash/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Haskell Platform
#[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}v/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
