#!/usr/bin/env python3
import argparse
import glob
import os
import re

import pymupdf


def get_sorted_pdf_list(exclude: str) -> list[str]:
    res = natural_sort(list(map(os.path.basename, glob.glob("./*.pdf"))))
    if exclude in res:
        res.remove(exclude)
    return res


def natural_sort(s: list[str]):
    def natural_sort_key(sl) -> list[int | str]:
        re_num = re.compile(r"(\d+)")
        return [
            int(text) if text.isdigit() else text.lower() for text in re_num.split(sl)
        ]

    res = sorted(s, key=natural_sort_key)

    return res


if __name__ == "__main__":
    cli = argparse.ArgumentParser()
    cli.add_argument("-o", "--output", help="output file name")
    args = cli.parse_args()

    print(f"Working in {os.getcwd()}")

    output_filename: str = "output.pdf"

    if args.output is not None:
        output_filename = args.output

    doc = pymupdf.open()

    o = []
    page_acc = 0

    for _, fn in enumerate(get_sorted_pdf_list(exclude=output_filename)):
        with pymupdf.open(fn) as f:
            doc.insert_pdf(f)
            o.append([1, fn, page_acc + 1])
            page_acc += f.page_count

    doc.set_toc(o)
    doc.save(output_filename)
