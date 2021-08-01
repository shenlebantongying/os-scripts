#!/usr/bin/env python3
import os
import shutil

(dirpath, _, filenames) = next(os.walk("../"))
for f in filenames:
    filepath=dirpath+f
    with open(filepath) as from_file:
        data = from_file.readline()
        if (data.strip()==r'#!/bin/bash'):
            with open(filepath+".new","w") as to_file:
                to_file.write("#!/usr/bin/env bash\n")
                shutil.copyfileobj(from_file, to_file)
                os.remove(filepath)
                os.rename(filepath+".new",filepath)
    print(filepath,data)

