#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -l -h --color=auto'

PS1='[\u@\h \W]\$ '

PATH=$PATH\
:${HOME}/.local/bin\
:${HOME}/bin\
:${HOME}/script

LESSOPEN="|lesspipe.sh %s"; export LESSOPEN

