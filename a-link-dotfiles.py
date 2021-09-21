#!/usr/bin/env python3
from pathlib import Path
import os
import sys

script_path=os.path.abspath(os.path.dirname(__file__))

def homeloc(route:str):
    return Path.joinpath(Path.home(),route)

def scrploc(route:str):
    return Path.joinpath(Path(script_path),"home",route)

def link_file(route:str):
    home_path=homeloc(route)
    scrp_path=scrploc(route)
    print(scrp_path)
    # check if the file exist as a symblink already?
    if Path.is_symlink(home_path):
        print( "[already linked] at "+str(home_path))
    elif Path.is_file(scrp_path):
        print("[Create symblink] "+ str(home_path) + " => " + str(scrp_path))
        os.symlink(scrp_path,home_path)

link_file(".bashrc")
