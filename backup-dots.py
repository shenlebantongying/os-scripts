import os
import pathlib
from shutil import copy2 as cp

fileList = open("filelist.txt", "r")


def slb_path(s):
    """
    Process raw path from filelist.txt
    :param s: posix path
    :return: (basename, absolate path)
    """
    s = s.rstrip()
    if s.startswith("~"):
        return str(s[2:]), str(pathlib.Path.home()) + s[1:]


for file in fileList:
    basename, abspath = slb_path(file)
    cp(abspath, "./dots/" + basename)
