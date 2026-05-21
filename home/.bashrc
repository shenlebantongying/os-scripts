# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# For Linux only.
if [[ $(uname) != "Darwin" ]]
then
	# Jump start Fish. Hack from https://wiki.archlinux.org/title/Fish#Modify_.bashrc_to_drop_into_fish
	# So that the default sh is still bash while fish as interactive sh when needed.
	if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
	then
		exec fish
	fi
fi
