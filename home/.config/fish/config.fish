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

         # M1 homebrew, we want to override some brew path
         if test "arm" = (uname -p)
             eval (/opt/homebrew/bin/brew shellenv)
         end


        set PATH \
            $HOME/Qt/6.2.0/macos/bin \
            $HOME/.ghcup/bin \
            $HOME/.cabal/bin \
            $HOME/.local/bin \
            $HOME/Library/Python/3.10/bin \
            $HOME/bin \
            $HOME/scripts \
            $HOME/.rbenv/bin \
            $HOME/.cargo/bin \
            $HOME/.emacs.d/bin \
            /usr/local/smlnj/bin \
        # shadowing system built-ins
            /opt/homebrew/opt/llvm/bin \
            # make GNU great again
            /opt/homebrew/opt/bison/bin \
            /opt/homebrew/opt/libxslt/bin \
            /opt/homebrew/opt/make/libexec/gnubin \
            $PATH

        # homebrew M1 mac specific completion
        if test -d (brew --prefix)"/share/fish/completions"
            set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
        end

        if test -d (brew --prefix)"/share/fish/vendor_completions.d"
            set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
        end

        source {$HOME}/.iterm2_shell_integration.fish

    case '*'
            echo !!!! OS undetectable
end



    # special paths
    if type -q "opam"
        eval (opam env)
    end
    if type -q "rbenv"
        source (rbenv init -|psub)
    end

    # taskwarrior
    if type -q "task"
        task list 
    end
end
