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

def _get_store_path() -> Path:
    if __STORE_PATH__ is not None:
        return __STORE_PATH__
    return Path("~/os-scripts/home").expanduser()

def init(p:str|None = None):
    global home_path
    global store_path
    if p is not None:
        global __STORE_PATH__
        __STORE_PATH__ = Path(p).expanduser()
    home_path = Path("~").expanduser()
    store_path = _get_store_path()

def _find_in_store_path(p: Path):
    return _get_store_path().joinpath(*p.expanduser().parts[3:])

def _file_discover(p: Path):
    if "*" in str(p):
        globbing_starts = 0
        for i, part in enumerate(p.parts):
            if "*" in part:
                globbing_starts = i
                break

        glob_path_home = Path(*p.parts[:globbing_starts])
        glob_expression = "".join(p.parts[globbing_starts:])

        glob_path_store =store_path.joinpath(*glob_path_home.parts[3:])

        found_in_home = (x.parts[3:] for x in list(glob_path_home.glob(glob_expression)))
        found_in_store = (x.parts[5:] for x in list(glob_path_store.glob(glob_expression)))

        for x in set(list(found_in_home) + list(found_in_store)):
            yield [store_path.joinpath(*x),home_path.joinpath(*x)]

    else:
        yield [_find_in_store_path(p),p]

def _check_symlink_exists(p:Path):
    if not p.is_symlink():
        raise MyException("symlink err")
    return p.resolve().exists()


def _sync_file_to(source_path: Path, target_path: Path):
    """
    replace the target_path with a symlink pointing to source_path
    """
    print(source_path, "<-" ,target_path)
    # TODO: this check need to be better.
    if (target_path.is_symlink() and target_path.resolve().exists()) or target_path.is_dir():
        return
    # move existing file to source_path then link back
    elif target_path.is_file():
        source_path.parent.mkdir(parents=True, exist_ok=True)
        target_path.rename(source_path)
        target_path.symlink_to(source_path)
    # we have source_path, let the target_path link back
    else:
        target_path.parent.mkdir(parents=True, exist_ok=True)
        source_path.parent.mkdir(parents=True, exist_ok=True)
        target_path.unlink(missing_ok=True)
        target_path.symlink_to(source_path)

def _sync(path_desc:Path):
    for x in _file_discover(path_desc):
        _sync_file_to(x[0], x[1])

def sync(path_desc: str):
    _sync(Path(path_desc).expanduser())

def sync_file_to(source_path: str, target_path: str):
    """
    link single file
    """
    _sync_file_to(_find_in_store_path(Path(source_path).expanduser()), Path(target_path).expanduser())
