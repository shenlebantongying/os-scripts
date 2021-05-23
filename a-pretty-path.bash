#!/bin/bash

# Hack to print raw string 

echo -e ${PATH//:/\\n}


# alternative
# tr ':' '\n' <<< "$PATH"
