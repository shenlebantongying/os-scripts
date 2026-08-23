# Fedora Linux Customs
if [[ $DISTRO = "Fedora" ]]; then
    . /etc/bashrc
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
