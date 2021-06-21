#!/bin/python3
import os

ll=[]
with open(os.path.expanduser("~/.newsboat/urls"),"r") as f:
    for l in f:
        ll.append(l.strip().replace("\"",""))
    ll.sort()

with open(os.path.expanduser("~/.newsboat/urls"),"w") as f:
    for l in ll:
        print(l,file=f)
