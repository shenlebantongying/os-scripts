import os
import pathlib
import platform
import sys
from pathlib import Path

"""
    Try automatically discover files on both side home <-> store

    if home missing file -> link file
    if home have more file -> move file to store + link file

    - TODO: force relink
"""

class MyException(Exception):
    """make ruff happy"""

__STORE_PATH__: Path | None = None
home_path: Path
store_path: Path

def get_store_path() -> Path:
    if __STORE_PATH__ is not None:
        return __STORE_PATH__
    match sys.platform:
        case "darwin":
            return pathlib.Path(os.path.expanduser("~/os-scripts/home"))
        case "linux":
            match platform.freedesktop_os_release()["ID"]:
                case _:
                    return pathlib.Path(os.path.expanduser("~/s/home"))

    raise MyException("Cannot resolve OS.")

def init(p:str|None = None):
    global home_path
    global store_path
    if p is not None:
        global __STORE_PATH__
        __STORE_PATH__ = pathlib.Path(os.path.expanduser(p))
    home_path = pathlib.Path("~").expanduser()
    store_path = get_store_path()


def file_discover(p: str):
    if "*" in p:
        original_path = pathlib.Path(p).expanduser()

        globbingStarts = 0
        for i, part in enumerate(original_path.parts):
            if "*" in part:
                globbingStarts = i
                break

        fixed_path_parts = original_path.parts[:globbingStarts]
        glob_expression = "".join(original_path.parts[globbingStarts:])

        glob_path_home = pathlib.Path(*fixed_path_parts)
        glob_path_store = pathlib.Path(store_path).joinpath(*glob_path_home.parts[3:])

        found_in_home = (x.parts[3:] for x in list(glob_path_home.glob(glob_expression)))

        found_in_store = (x.parts[5:] for x in list(glob_path_store.glob(glob_expression)))

        for x in set(list(found_in_home) + list(found_in_store)):
            yield [home_path.joinpath(*x), store_path.joinpath(*x)]

    else:
        f_path_home = pathlib.Path(p).expanduser()
        f_path_store = get_store_path().joinpath(*f_path_home.parts[3:])
        yield [f_path_home, f_path_store]

def check_symlink_exists(p:pathlib.Path):
    if not p.is_symlink():
        raise MyException("symlink err")
    return p.resolve().exists()

def operate(home_path: pathlib.Path, store_path: pathlib.Path):
    print(home_path, store_path)
    # TODO: this check need to be better.
    if (home_path.is_symlink() and home_path.resolve().exists()) or home_path.is_dir():
        return
    elif home_path.is_file():
        os.makedirs(store_path.parent, exist_ok=True)
        home_path.rename(store_path)
        home_path.symlink_to(store_path)
    else:
        os.makedirs(home_path.parent, exist_ok=True)
        os.makedirs(store_path.parent, exist_ok=True)
        if home_path.exists():
            home_path.unlink()
        home_path.symlink_to(store_path)

def sync(path_desc:str):
    for x in file_discover(path_desc):
        operate(x[0], x[1])
