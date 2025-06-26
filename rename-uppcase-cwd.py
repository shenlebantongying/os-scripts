#!/usr/bin/env python3
import os

with os.scandir() as it:
    for entry in it:
        if not entry.name.startswith('.') and entry.is_file():
            old_name=entry.name
            upper_name=old_name.upper()
            if(upper_name!=old_name):
                os.rename(old_name,upper_name)
        