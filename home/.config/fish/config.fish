if status is-interactive
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
                $HOME/.local/bin \
                $HOME/bin \
                $HOME/scripts \
                $HOME/.cabal/bin \
                $HOME/.rbenv/bin \
                $HOME/.cargo/bin \
                $HOME/.emacs.d/bin \
            $PATH
        case '*'
                echo !!!! OS undetectable
    end
end
