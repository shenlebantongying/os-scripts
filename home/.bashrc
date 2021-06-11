# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Copied from ubuntu's default
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

EDITOR=vim

alias ls='ls --color=auto'
alias a-addrss='vim ~/.newsboat/urls'
alias vim='nvim'
alias vimdiff='nvim -d'

#conflict with llvm's ll 
#alias ll='ls -l -h --color=auto'

PS1='\n[\t \w]\n\$ '

PATH=$PATH\
:${HOME}/.local/bin\
:${HOME}/bin\
:${HOME}/script\
:${HOME}/.dotnet\
:${HOME}/.ghcup/


# TODO: what is inside the env script?
. "$HOME/.cargo/env"
[ -f "/home/slbtty/.ghcup/env" ] && source "/home/slbtty/.ghcup/env" # ghcup-env

LESSOPEN="|lesspipe.sh %s"; export LESSOPEN


# Extra commands

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
}

function gitcom() {
  git commit -m "[> $(date -u)"
}