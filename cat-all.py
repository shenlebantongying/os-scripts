#!/usr/bin/env python3

import os
import subprocess

# this is intended to be used with as
# cat-all.py | fzf

IGNORE=[".git",".vscode"]

pwd=os.getcwd()
cwdlength=len(pwd)

for  (dirpath, dirnames, filenames) in os.walk(pwd):
    if not any(ig in dirpath for ig in IGNORE):
        for file in filenames:
            fullpath=dirpath+"/"+file
            ftype=subprocess.check_output(["file","--dereference","--brief", "--mime-type", fullpath]).decode()
            
            if(ftype.startswith("text")):
                with open(fullpath,"r") as f:
                    for ln,line in enumerate(f,start=1):
                        if not line.isspace():
                            print(fullpath[cwdlength+1:],"|",ln,"|",line.strip())