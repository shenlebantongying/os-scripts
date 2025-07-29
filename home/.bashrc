# For Linux-based system only.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

. "$HOME/.cargo/env"

if [[ $(uname) != "Darwin" ]]
then 
	if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
	then
		exec fish
	fi
fi

