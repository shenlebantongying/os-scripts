function view
    switch (uname)
        case Linux
            $argv | kate -i &> /dev/null &; disown
        case Darwin
            $argv | col -b | open -tf
        case '*'
            echo !!!! editor not set.
    end
end
