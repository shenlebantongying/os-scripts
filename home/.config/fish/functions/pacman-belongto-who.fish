function pacman-belongto-who --description 'what pkg does a file belong to?'
    pacman -Qo $argv
end