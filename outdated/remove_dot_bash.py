#!/usr/bin/env python3
from os import listdir,chdir,rename
from os.path import dirname,abspath

# rootdir

chdir(dirname(dirname(abspath(__file__))))
for f in listdir():
    if f.endswith(".bash"):
        with open(f,"r") as fle:
            if(fle.readline().startswith(r"#!")):
                rename(f,f.replace(".bash",""))
