# For Linux-based system only.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Precedence for interactive shell:
# 1. Personal scripts/Binaries
# 2. Language's dedicated manager
# 3. Nix or Guix
# 4. Flatpak/Snap
# 5. System's package

#[ NIX
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
#] END NIX

PATH=${HOME}/s\
:${HOME}/bin\
:${HOME}/.deno/bin\
:${HOME}/.local/bin\
:${HOME}/.opam/default/bin\
:${HOME}/.ghcup/bin\
:${HOME}/.cabal/bin\
:${HOME}/.rbenv/bin\
:${HOME}/.cargo/bin\
:${HOME}/.emacs.d/bin\
:${HOME}/.local/share/coursier/bin\
:${HOME}/.dotnet\
:$PATH\
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

export PS1="[\[\e[32m\]\A\[\e[m\]] \u@\h \[\e[34m\]\w\[\e[m\] \n> "
export LESSOPEN="|lesspipe.sh %s"; export LESSOPEN
export LESS='--mouse --wheel-lines=10'
# Extra commands

## Copied from ubuntu's default
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# a hack to make cd easier.
# cd ./nice -> cd nice
CDPATH=".:..:~:/"

export EDITOR=nvim
export VISUAL=nvim

# better defaults
# alias ls='ls --color=auto' #too ugly
alias pstree='pstree --highlight-all --show-pids --hide-threads'
alias vim='nvim'
alias vimdiff='nvim -d'

# handy toolkits
alias open="kde-open5 &>/dev/null"
alias byte2readable='numfmt --to=iec-i --suffix=B'
alias cmx='chmod +x'
alias gs='git status -sb'
alias a-rss='emacs ~/.newsboat/urls'
alias fzfopen='kde-open5 $(fzf) &> /dev/null'
alias date-simple="date +"%Y-%m-%d""

# shortcuts
alias sublime='subl'
alias merge='smerge'

#wraping lisp
# -> give power to their shell without using GNU readline
alias cl="rlwrap lisp"
alias sml="rlwrap smlnj"
alias maxima="rlwrap maxima" # rmaxima also works
alias fsi="dotnet fsi"

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

# Antlr and java
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.defaultlaf=javax.swing.plaf.nimbus.NimbusLookAndFeel'
alias antlr4='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.Tool'
alias grun='java -Xmx500M -cp "/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH" org.antlr.v4.gui.TestRig'

export CLASSPATH=".:/usr/local/lib/antlr-4.9-complete.jar:$CLASSPATH"

function krm(){
    kioclient5 move "$@" trash:/
}

function peek(){
    eval "$@" 2>/dev/null | kate -i &>/dev/null & 
}


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
