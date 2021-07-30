#!/usr/bin/env python3
import requests
import sys

username="shenlebantongying"
token=""
aAuth=(username,token)

r = requests.get("https://api.github.com/orgs/ArtifactCabinet/issues?filter=all&state=all",auth=aAuth)

print(r.text)

# ./list-all-issues-assigned-to-u.py | jq '.[] | {url,title}'