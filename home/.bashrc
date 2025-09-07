# For Linux-based system only.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -f "$HOME/.cargo/env" ]]; then
	. "$HOME/.cargo/env"
fi

export PATH="$HOME/.juliaup/bin:$PATH"

if [[ $(uname) != "Darwin" ]]
then
	if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
	then
		exec fish
	fi
fi
