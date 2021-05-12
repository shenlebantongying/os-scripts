#!/usr/bin/env python3
import os
import xml.etree.ElementTree as e
import tempfile

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

def html(s): return "<!doctype html>\n<html><head><title>rss.opml</title></head><body>{}</body></html>".format(s)
def ul(s): return '<ul>{}</ul>'.format(s)
def li(s): return '<li>{}</li>'.format(s)
def li_a(s, href): return '<li><a href="{href}">{s}</a></li>'.format(href=href, s=s)

def scan_outline(e):
    if len(e) == 0:
        if attr_exist(e, 'htmlUrl'):
            return li_a(e.attrib["text"], e.attrib["htmlUrl"])
        else:
            return li(e.attrib["text"])
    else:
        if e.tag != "body":
            l = [li(e.attrib["text"])]
        else:
            l=[]

        for c in e:
            l.append(scan_outline(c))
        return ul(''.join(l))

f=tempfile.NamedTemporaryFile(suffix='.html',mode="w",delete=False)
f.write(html(scan_outline(r)))
f.close()
os.system("xdg-open " + f.name)
