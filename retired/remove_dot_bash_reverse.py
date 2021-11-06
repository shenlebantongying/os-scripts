#!/usr/bin/env python3
from os import walk, rename

PA="/home/slbtty/s/"
(_, _, filenames) = next(walk(PA))
for f in filenames:
    with open(PA+f,"r") as fle:
        if(fle.readline().startswith(r"#!/usr/bin/env bash")):
            print(">>>>",PA+f)
            rename(f,f+".bash")
