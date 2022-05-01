if status is-interactive

# [PATH]
#======================================================
switch (uname)
    case Linux
        set PATH \
            $HOME/.deno/bin \
            $HOME/npm/bin \
            $HOME/go/bin \
            $HOME/.ghcup/bin \
            $HOME/.local/bin \
            $HOME/.tracko \
            $HOME/bin \
            $HOME/s \
            $HOME/.dotnet \
            $HOME/.cabal/bin \
            $HOME/.rbenv/bin \
            $HOME/.cargo/bin \
            $HOME/.emacs.d/bin \
            $HOME/.local/share/coursier/bin \
            /usr/local/Wolfram/Mathematica/12.3/Executables \
            $PATH
    case Darwin

        # M1 homebrew, we want to override some brew path
        if test "arm" = (uname -p)
             eval (/opt/homebrew/bin/brew shellenv)
        end

        set PATH \
            $HOME/Qt/6.2.0/macos/bin \
            $HOME/.ghcup/bin \
            $HOME/.cabal/bin \
            $HOME/.local/bin \
            $HOME/bin \
            $HOME/scripts \
            $HOME/.rbenv/bin \
            $HOME/.cargo/bin \
            $HOME/.emacs.d/bin \
            $HOME/npm/bin \
            /usr/local/smlnj/bin \
        # Scala
            "$HOME/Library/Application Support/Coursier/bin" \
        # Python
            $HOME/Library/Python/3.10/bin \
            /opt/homebrew/opt/python@3.10/bin \
        # shadowing system built-ins
            /opt/homebrew/opt/llvm/bin \
            # make GNU great again
            /opt/homebrew/opt/findutils/libexec/gnubin \
            /opt/homebrew/opt/bison/bin \
            /opt/homebrew/opt/libxslt/bin \
            /opt/homebrew/opt/make/libexec/gnubin \
            /opt/homebrew/opt/grep/libexec/gnubin \
            # TCL/TK
            /opt/homebrew/opt/tcl-tk/bin/ \
        # Fix crazy homebrew
           /opt/homebrew/opt/gambit-scheme/current/bin \
            $PATH

        # homebrew M1 mac specific completion
        if test -d (brew --prefix)"/share/fish/completions"
            set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
        end

        if test -d (brew --prefix)"/share/fish/vendor_completions.d"
            set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
        end

    case '*'
            echo !!!! OS undetectable
end

    set -gx CDPATH . .. ~ /
    set -gx EDITOR emacs -nw -q
    set -gx PAGER cat
    set -gx SYSTEMD_PAGER cat
    set -gx NO_COLOR

    # special paths
    if type -q "opam"
        eval (opam env --shell=fish)
    end
    if type -q "rbenv"
        source (rbenv init -|psub)
    end
    if type -q "zoxide"
        zoxide init fish | source
    end

    # taskwarrior
    # if type -q "task"
        # task list 
    # end
end
