#!/usr/bin/env python3
import os
import xml.etree.ElementTree as e
import tempfile

# TODO: strip feed.rss at the end

"""
Perview rss.opml with browser
"""
def get_subtree(ele, s):
    for c in ele:
        if c.tag == s:
            return c

def attr_exist(ele, s):
    if s in ele.attrib.keys():
        return True

r = get_subtree(e.parse('rss.opml').getroot(), 'body')

def html(s): return "<!doctype html>\n<html><head><title>rss.opml</title></head>\n<body>\n{}\n</body></html>".format(s)
def ul(s): return '<ul>{}</ul>\n'.format(s)
def li(s): return '\t<li>{}</li>\n'.format(s)
def li_a(s, href): return '\t<li><a href="{href}">{s}</a></li>\n'.format(href=href, s=s)

def scan_outline(e):
    if len(e) == 0:
        if attr_exist(e, 'xmlUrl'):
            return li_a(e.attrib["title"], e.attrib["xmlUrl"])
        else:
            return li(e.attrib["title"])
    else:
        if e.tag != "body":
            l = [li(e.attrib["title"])]
        else:
            l=[]

        for c in e:
            l.append(scan_outline(c))
        return ul(''.join(l))

f=tempfile.NamedTemporaryFile(suffix='.html',mode="w",delete=False)
f.write(html(scan_outline(r)))
f.close()
os.system("nohup xdg-open " + f.name + " >/dev/null 2>&1 ")
