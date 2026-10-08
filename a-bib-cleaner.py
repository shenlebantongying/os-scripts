#!/usr/bin/env python

import argparse
from pathlib import Path
import re
from difflib import context_diff

def get_regex() -> re.Pattern:
    banned_bib_keywords = [
        "file",
        "isbn",
        "keywords",
        "langid",
        "rights",
        "abstract",
        "urldate",
        "pagetotal",
        "location"

    ]
    reg_middle="|".join(banned_bib_keywords)
    return re.compile(f"^\\s*({reg_middle})")

class mExceptino(Exception):
    pass

def get_argfile()-> Path:
    parser = argparse.ArgumentParser()
    parser.add_argument("file")
    args=parser.parse_args()

    return Path(args.file)


if __name__ == '__main__':
    source_file = get_argfile().resolve()
    target_file = source_file.with_name(source_file.name + ".tmp")

    reg = get_regex()

    with (
        open(source_file,"r") as source,
        open(target_file,"w") as target
    ):
        for line in source:
            if reg.search(line) is None:
                target.write(line)

    with (
        open(source_file,"r") as source,
        open(target_file,"r") as target
    ):
        for l in context_diff(source.readlines(),target.readlines()):
            print(l[:50])

    target_file.move(source_file)
