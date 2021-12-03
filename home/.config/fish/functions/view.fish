function view
    switch (uname)
        case Linux
            eval $argv 2>/dev/null | kate -i &>/dev/null & 
        case Darwin
            eval $argv | col -b | open -tf 
        case '*'
            echo !!!! editor not set.
    end
end