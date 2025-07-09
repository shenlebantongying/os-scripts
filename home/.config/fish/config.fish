if status is-interactive

    set -g CDPATH "~"

    switch (uname)
        case Linux
            # path settings are within .bashrc
            set -gx DEBUGINFOD_URLS "https://debuginfod.archlinux.org"

            set -gx EDITOR subl
            set -gx SYSTEMD_PAGER cat

            set -gx DOTNET_ROOT $HOME/.dotnet

        case Darwin

            # M1 homebrew, we want to override some brew path
            if test arm = (uname -p)
                eval (/opt/homebrew/bin/brew shellenv)
            end

            set PATH \
                $HOME/opt/bin \
                $HOME/.deno/bin \
                $HOME/.ghcup/bin \
                $HOME/.cabal/bin \
                $HOME/.local/bin \
                $HOME/bin \
                $HOME/scripts \
                $HOME/.traco \
                $HOME/.rbenv/bin \
                $HOME/.cargo/bin \
                $HOME/.emacs.d/bin \
                $HOME/npm/bin \
                # dotnet
                $HOME/.dotnet/tools \
                # shadowing system built-ins
                /opt/homebrew/opt/llvm/bin \
                # make GNU great again
                /opt/homebrew/opt/findutils/libexec/gnubin \
                /opt/homebrew/opt/coreutils/libexec/gnubin \
                /opt/homebrew/opt/make/libexec/gnubin \
                /opt/homebrew/opt/bison/bin \
                /opt/homebrew/opt/libxslt/bin \
                /opt/homebrew/opt/grep/libexec/gnubin \
                # TCL/TK
                /opt/homebrew/opt/tcl-tk/bin/ \
                # Ruby
                /opt/homebrew/lib/ruby/gems/3.3.0/bin \
                /opt/homebrew/opt/ruby/bin \
                $PATH

            # homebrew M1 mac specific completion
            if test -d (brew --prefix)"/share/fish/completions"
                set -p fish_complete_path (brew --prefix)/share/fish/completions
            end

            if test -d (brew --prefix)"/share/fish/vendor_completions.d"
                set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
            end

            # special paths
            if type -q opam
                eval (opam env --shell=fish)
            end

            if type -q groovy
                set -gx GROOVY_HOME /opt/homebrew/opt/groovy/libexec
            end

        case '*'
            echo !!!! OS undetectable
    end

    if type -q zoxide
        zoxide init fish | source
    end

    abbr -a -- jl 'julia --banner=no'
    abbr -a -- R 'R -q'
    abbr -a -- jupy-to-py 'jupytext --to py:percent --opt comment_magics=false'
    abbr -a -- py-to-jupy 'jupytext --to notebook'

    abbr -a -- git-del-all-other-branches 'git branch | rg -v (git branch --show-current) | xargs git branch -D'
end
