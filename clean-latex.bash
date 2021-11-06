#!/usr/bin/env bash

# the first arg will clean specific file

arg=${1:-.}
exts="aux bbl blg brf idx ilg ind lof log lol lot out toc synctex.gz fdb_latexmk fls pdf_tex"

if [ -d "$arg" ]; then
    for ext in $exts; do
         rm -f "$arg"/*."$ext"
    done
else
    for ext in $exts; do
         rm -f "$arg"."$ext"
    done
fi