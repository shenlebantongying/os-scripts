function rm-invalid-links.fish
    # note that this require GNU find
    find . -xtype l -delete
end