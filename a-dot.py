#!/usr/bin/env python3

import sys
import pathlib
import os
import platform

"""
    Try automatically discover files on both side home <-> store

    if home missing file -> link file
    if home have more file -> move file to store + link file

    - TODO: force relink
"""


def get_store_path() -> pathlib.Path:
    match sys.platform:
        case "darwin":
            return pathlib.Path(os.path.expanduser("~/os-scripts/home"))
        case "linux":
            match platform.freedesktop_os_release()["ID"]:
                case "fedora-asahi-remix":
                    return pathlib.Path(os.path.expanduser("~/os-scripts/home"))
                case _:
                    return pathlib.Path(os.path.expanduser("~/s/home"))

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

        found_in_home = map(
            lambda x: x.parts[3:], list(glob_path_home.glob(glob_expression))
        )

        found_in_store = map(
            lambda x: x.parts[5:], list(glob_path_store.glob(glob_expression))
        )

        for x in set(list(found_in_home) + list(found_in_store)):
            yield [home_path.joinpath(*x), store_path.joinpath(*x)]

    else:
        f_path_home = pathlib.Path(p).expanduser()
        f_path_store = get_store_path().joinpath(*f_path_home.parts[3:])
        yield [f_path_home, f_path_store]


def operate(home_path: pathlib.Path, store_path: pathlib.Path):
    print(home_path, store_path)
    if home_path.is_symlink() or home_path.is_dir():
        return
    elif home_path.is_file():
        os.renames(home_path, store_path)
        os.makedirs(home_path.parent, exist_ok=True)
        os.makedirs(store_path.parent, exist_ok=True)
        home_path.symlink_to(store_path)
    else:
        os.makedirs(home_path.parent, exist_ok=True)
        os.makedirs(store_path.parent, exist_ok=True)
        home_path.symlink_to(store_path)


if __name__ == "__main__":
    path_file = pathlib.Path(__file__).resolve().parent / "a-dot.txt"
    with open(path_file) as pfile:
        for line in pfile:
            if len(line) < 2 or line[0].startswith("#"):
                continue
            for x in file_discover(line.strip()):
                operate(x[0], x[1])
