#
# ~/.bash_profile

PATH=\
~/.deno/bin\
:~/npm/bin\
:~/go/bin\
:~/.ghcup/bin\
:~/.local/bin\
:~/.traco\
:~/bin\
:~/s\
:~/.dotnet\
:~/.Dotnet/Tools\
:~/.Cabal/bin\
:~/.rbenv/bin\
:~/.cargo/bin\
:~/.emacs.d/bin\
:/usr/local/Wolfram/14.2/Executables/\
:$PATH

if command -v opam &> /dev/null
then
eval "$(opam env)"
fi

if command -v rbenv &> /dev/null
then
   eval "$(rbenv init - bash)"
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
