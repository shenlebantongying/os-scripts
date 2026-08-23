function pretty-path
    if test (count $argv) -eq 0
        set -f pp $PATH
    else
        set -f pp $argv
    end

    for pa in $pp
        echo "$pa"
    end
end
