#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=vim

alias ls='ls --color=auto'

#conflict with llvm's ll 
#alias ll='ls -l -h --color=auto'

PS1='[\u@\h \W]\$ '

PATH=$PATH\
:${HOME}/.local/bin\
:${HOME}/bin\
:${HOME}/script\
:${HOME}/.cargo/bin

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

. "$HOME/.cargo/env"
