if status is-interactive

# [PATH]
#======================================================
switch (uname)
    case Linux
        set PATH \
            $HOME/.ghcup/bin \
            $HOME/.local/bin \
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
        set PATH \
            $HOME/.ghcup/bin \
            $HOME/.cabal/bin \
            $HOME/.local/bin \
            $HOME/Library/Python/3.9/bin \
            $HOME/bin \
            $HOME/scripts \
            $HOME/.rbenv/bin \
            $HOME/.cargo/bin \
            $HOME/.emacs.d/bin \
            /usr/local/smlnj/bin \
            /opt/homebrew/opt/llvm/bin \
            $PATH

        source {$HOME}/.iterm2_shell_integration.fish
    case '*'
            echo !!!! OS undetectable
end

    # M1 homebrew 
    if test "arm" = (uname -p)
        eval (/opt/homebrew/bin/brew shellenv)
    end

    # special paths
    if type -q "opam"
        eval (opam env)
    end
    if type -q "rbenv"
        source (rbenv init -|psub)
    end
end
