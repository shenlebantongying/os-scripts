# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Copied from ubuntu's default
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# a hack to make cd easier.
# cd ./nice -> cd nice
CDPATH=".:~"

export EDITOR=nvim
export VISUAL=nvim


# better defaults
alias ls='ls --color=auto'
alias pstree='pstree --highlight-all --show-pids --hide-threads'
alias vim='nvim'
alias vimdiff='nvim -d'

# handy toolkits
alias byte2readable='numfmt --to=iec-i --suffix=B'
alias cmx='chmod +x'
alias gs='git status -sb'
alias a-rss='emacs ~/.newsboat/urls'
alias fzfopen='kde-open5 $(fzf) &> /dev/null'
alias date-simple="date +"%Y-%m-%d""

# shortcuts
alias v='nvim-qt'
alias e='emacs'
alias sublime='subl'
alias merge='smerge'

# nav expert
alias q='cd ..'
alias qq='cd ../..'
alias qqq='cd ../../..'

# mad man nav
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

#wraping lisp
# -> give power to their shell without using GNU readline
alias cl="rlwrap lisp"
alias sml="rlwrap smlnj"
alias maxima="rlwrap maxima" # rmaxima also works
alias fsi="dotnet fsi"

#conflict with llvm's ll 
#alias ll='ls -l -h --color=auto'

PS1='\n[\t \w]\n\$ '

PATH=$PATH\
:${HOME}/.local/bin\
:${HOME}/bin\
:${HOME}/s\
:${HOME}/.dotnet\
:${HOME}/.ghcup/bin\
:${HOME}/.cabal/bin\
:${HOME}/.rbenv/bin\
:${HOME}/.cargo/bin\
:${HOME}/.emacs.d/bin\
:/usr/local/Wolfram/Mathematica/12.3/Executables

# Fixme -> shorter version?
if command -v opam &> /dev/null
then
eval "$(opam env)"
fi

if command -v rbenv &> /dev/null
then
    eval "$(rbenv init - bash)"
fi

# -> uselss, env files are just appending PATH withe extra steps
# [ -f "${HOME}/.ghcup/env" ] && source "${HOME}/.ghcup/env" # ghcup-env
# [ -f "${HOME}/.cargo/env" ] && source "${HOME}/.cargo/env"

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

# function gitcom() {
#     git commit -m "[> $(date -u)"
# }


# Antlr and java

# disabled due to annoyance
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=javax.swing.plaf.nimbus.NimbusLookAndFeel'

alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"

function krm(){
    kioclient5 move "$@" trash:/
}
