switch (uname)
    case Darwin
        eval (/opt/homebrew/bin/brew shellenv)

        set PATH \
            $HOME/bin \
            $HOME/opt/bin \
            $HOME/.local/bin \
            $HOME/os-scripts \
            $HOME/.ghcup/bin \
            $HOME/.julia/bin \
            $HOME/.cargo/bin \
            /opt/homebrew/opt/rustup/bin \
            # dotnet
            $HOME/.dotnet/tools \
            # make GNU great again
            /opt/homebrew/opt/findutils/libexec/gnubin \
            /opt/homebrew/opt/coreutils/libexec/gnubin \
            /opt/homebrew/opt/make/libexec/gnubin \
            $PATH
    # NOTE: for Linux, the path settings are in bash_profile.
end


if status is-interactive
    switch (uname)
        case Linux

            set -gx EDITOR kate
            set -gx SYSTEMD_PAGER cat
            set -gx DOTNET_ROOT $HOME/.dotnet

            switch (lsb-release -is)
                case Fedora
                    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)
                    if test -d (brew --prefix)"/share/fish/completions"
                        set -p fish_complete_path (brew --prefix)/share/fish/completions
                    end
                    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
                        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
                    end

                case '*'
                    # path settings are within .bashrc
                    set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

            end

        case Darwin
            set -gx HOMEBREW_NO_UPGRADE_AUTO_UPDATES_CASKS 1

            # special paths
            if type -q opam
                eval (opam env --shell=fish)
            end

        case '*'
            echo !!!! OS undetectable
    end

    set -g CDPATH "~"

    if type -q zoxide
        zoxide init fish | source
    end

    abbr -a -- jl 'julia --banner=no'
    abbr -a -- R 'R -q'
    abbr -a -- em 'emacsclient --no-wait'

    abbr -a -- jupy-to-py 'jupytext --to py:percent --opt comment_magics=false'
    abbr -a -- py-to-jupy 'jupytext --to notebook'

    abbr -a -- git-del-all-other-branches 'git branch | rg -v (git branch --show-current) | xargs git branch -D'
end
