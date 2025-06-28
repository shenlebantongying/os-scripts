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
:~/.dotnet/tools\
:~/.cabal/bin\
:~/.rbenv/bin\
:~/.cargo/bin\
:~/.emacs.d/bin\
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

if [ -e /home/slbtty/.nix-profile/etc/profile.d/nix.sh ]; then . /home/slbtty/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"
