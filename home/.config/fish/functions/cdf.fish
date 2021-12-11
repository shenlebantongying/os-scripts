function cdf  --description 'cd with fzf and fd'
    cd (fd --type directory | fzf)
end
