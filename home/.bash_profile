# For Linux Only

if [[ $(uname) != "Darwin" ]]
then

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
:~/.juliaup/bin\
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

if [[ -f "$HOME/.cargo/env" ]]; then
   . "$HOME/.cargo/env"
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

fi
