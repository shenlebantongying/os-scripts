#!/usr/bin/env python3

def make_offset(off: int):
    if off > 1:
        print("""PageLabelBegin
PageLabelNewIndex: 1
PageLabelStart: 1
PageLabelPrefix: cover
PageLabelNumStyle: NoNumber""")

    if off > 2:
        print("""PageLabelBegin
PageLabelNewIndex: 2
PageLabelStart: 1
PageLabelNumStyle: LowercaseRomanNumerals""")

    print(f"""PageLabelBegin
PageLabelNewIndex: {off}
PageLabelStart: 1
PageLabelNumStyle: DecimalArabicNumerals""")


def make_bookmark(t: str, l: int, p: int):
    print(f"""BookmarkBegin
BookmarkTitle: {t}
BookmarkLevel: {l}
BookmarkPageNumber: {p}""")


if __name__ == '__main__':
    offset = int(input())
    make_offset(offset)
    while True:
        try:
            line = input()
            if not line.strip():
                break
        except EOFError:
            break

        title = " ".join(line.split()[0:-1])
        n_of_tabs = len(line) - len(line.lstrip())
        page = int(line.split()[-1])

        make_bookmark(t=title,
                      l=n_of_tabs + 1,
                      p=page + offset - 1)
