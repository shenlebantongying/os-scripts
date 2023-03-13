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
:~/.cabal/bin\
:~/.rbenv/bin\
:~/.cargo/bin\
:~/.emacs.d/bin\
:~/.local/share/coursier/bin\
:/usr/local/Wolfram/Mathematica/12.3/Executables\
:/usr/share/perl6/site/bin\
:/usr/lib/jvm/java-19-openjdk/bin/\
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
