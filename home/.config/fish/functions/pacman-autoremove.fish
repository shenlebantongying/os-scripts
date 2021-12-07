function pacman-autoremove
    set fish_trace 1
    sudo pacman -Qdtq | sudo pacman -Rs -
end
