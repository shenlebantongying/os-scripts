# shellcheck disable=SC2148
# For Linux Only
[[ $(uname) != "Linux" ]] && return

# Overcome bug of Fedora, where they could source this file twice.
[[ -n "$DISTRO" ]] && return
DISTRO=$(lsb_release -is)
export DISTRO

if [[ $DISTRO = "Fedora" ]]; then
    . /etc/bashrc
fi

PATH="$HOME/os-scripts\
:$HOME/s\
:$HOME/bin\
:$HOME/.local/bin\
:/var/lib/flatpak/exports/bin\
:$HOME/.deno/bin\
:$HOME/npm/bin\
:$HOME/go/bin\
:$HOME/.juliaup/bin\
:${PATH}"

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

[[ -f "$HOME/.bash_local.bash" ]] && source "$HOME/.bash_local.bash"

export PATH
