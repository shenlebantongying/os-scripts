#!/usr/bin/env python3
import fitz, sys

if __name__ == '__main__':
    doc = fitz.Document(sys.argv[1])

    offset=int(input())
    fitz.utils.set_page_labels(doc,
        [{'startpage': 0, 'prefix': '', 'style': 'r', 'firstpagenum': 1},
         {'startpage': offset, 'prefix': '', 'style': 'D', 'firstpagenum': 1}])

    line = ""
    toc=[]
    while True:
        try:
            line = input()
            if not line.strip():
                break
        except EOFError:
            break

        # calculate tab numbers and plus one
        level = len(line) - len(line.lstrip()) + 1
        title = " ".join(line.split()[0:-1])
        page = int(line.split()[-1])

        toc.append([level,title,page+offset])

    fitz.utils.set_toc(doc,toc,collapse=0)
    doc.save("output.pdf")