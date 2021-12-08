function rm-invalid-links
    # note that this require GNU find
    find . -xtype l -delete
end