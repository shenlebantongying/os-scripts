#!/usr/bin/env python3

import sys
import pathlib
import os

# home_path => the home dir
# store_path  => the git repo

def get_store_path() -> pathlib.Path:
    match sys.platform:
        case "darwin":
            return pathlib.Path(os.path.expanduser('~/scripts/home'))
        case "linux":
              return pathlib.Path(os.path.expanduser('~/s/home'))

def filetable(p:str):
    if "*" in p:
        glob_start=p.find("*")
        glob = p[glob_start:]
        p=p[:glob_start]
        hpath = pathlib.Path(p).expanduser()
        spath = pathlib.Path(get_store_path()).joinpath(*hpath.parts[3:])
        table= dict.fromkeys(list(map(lambda x: x.parts[3:],list(hpath.glob(glob))))+ \
            list(map(lambda x: x.parts[3+2:],list(spath.glob(glob)))))
        for x in table:
            yield [pathlib.Path.home().joinpath(*x), get_store_path().joinpath(*x)]
    else:
        home_path = pathlib.Path(p).expanduser()
        store_path = get_store_path().joinpath(*home_path.parts[3:])
        yield [home_path,store_path]

def operate(home_path:pathlib.Path,store_path:pathlib.Path):
    print(home_path,store_path)
    if home_path.is_symlink():
        return
    elif home_path.is_file():
        os.renames(home_path,store_path)
        os.makedirs(home_path.parent,exist_ok=True)
        os.makedirs(store_path.parent,exist_ok=True)
        home_path.symlink_to(store_path)
    else:
        os.makedirs(home_path.parent,exist_ok=True)
        os.makedirs(store_path.parent,exist_ok=True)
        home_path.symlink_to(store_path)

if __name__ == '__main__':
    path_file = pathlib.Path(__file__).resolve().parent / "a-dot.txt"
    with open(path_file) as pfile:
        for line in pfile:
            if len(line)<2 or line[0].startswith("#"):
                continue
            for x in filetable(line.strip()):
                operate(x[0],x[1])