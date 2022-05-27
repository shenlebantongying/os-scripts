# For Linux-based system only.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=\
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
:$PATH

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi
