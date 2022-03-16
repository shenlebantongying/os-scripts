function task-open
    task _get $argv.url | xargs xdg-open
end
