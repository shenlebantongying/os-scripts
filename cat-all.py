#!/usr/bin/env python3

import os,sys, subprocess

# this is intended to be used with as
# cat-all.py | fzf

IGNORE_DIRS=[".git",".vscode","build"]
pwd=os.getcwd()

for  (dirpath, dirnames, filenames) in os.walk(pwd):
    if not any(ig in dirpath for ig in IGNORE_DIRS):
        for file in filenames:
            full_path=dirpath+"/"+file
            relative_path=full_path[len(pwd)+1:]

            mimetype=subprocess.check_output(["file","--dereference","--brief", "--mime-type", full_path]).decode()
            
            if(mimetype.startswith("text")):
                try:
                    with open(full_path,"r") as f:
                        for ln,line in enumerate(f,start=1):
                            if not line.isspace():
                                print(relative_path,"|",ln,"|",line.strip())
                except:
                    print("[FAILED] ",full_path, file=sys.stderr) 