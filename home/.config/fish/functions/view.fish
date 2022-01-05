function view
    switch (uname)
        case Linux
            kate (eval $argv | psub) &
        case Darwin
            eval $argv | col -b | open -tf 
        case '*'
            echo !!!! editor not set.
    end
end
