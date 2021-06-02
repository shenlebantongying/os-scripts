#!/usr/bin/env python3
import requests
import sys

username="shenlebantongying"
token=""
aAuth=(username,token)

r = requests.get("https://api.github.com/orgs/ArtifactCabinet/repos",auth=aAuth)

for repo in r.json():
    print(repo['git_url'])
