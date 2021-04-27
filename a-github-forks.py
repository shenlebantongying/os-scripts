#!/usr/bin/env python3
import requests
import sys

username="shenlebantongying"
token=""
aAuth=(username,token)

r = requests.get(sys.argv[1].replace("https://github.com/", "https://api.github.com/repos/")+"/forks?sort=stargazers",auth=aAuth)

for repo in r.json():
    print("stars "+str(repo["stargazers_count"])+" "+str(repo["html_url"]))
