#!/usr/bin/env python3
"""Subset the web fonts used by the Chinese site into site/font/.

The book body uses LXGW WenKai, code uses Sarasa Gothic SC, and navigation
uses MiSans. All three are CJK faces; we only ship the glyphs actually shown,
otherwise each file would be tens of megabytes.

Re-run this after adding chapters that introduce new characters:

    python util/subset_fonts.py

Source TTFs are downloaded once into util/fonts-src/ and cached there.
"""

import os
import subprocess
import string
import sys
import urllib.request

from fontTools import subset

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC_DIR = os.path.join(ROOT, "util", "fonts-src")
OUT_DIR = os.path.join(ROOT, "site", "font")
SITE_DIR = os.path.join(ROOT, "site")

# (source file name, download url, output woff2 name, family, weight range)
FONTS = [
    (
        "LXGWWenKai-Regular.ttf",
        "https://github.com/lxgw/LxgwWenKai/releases/download/v1.522/LXGWWenKai-Regular.ttf",
        "lxgw-wenkai.woff2",
        "LXGW WenKai",
        "400",
    ),
    # Sarasa ships only as .7z/.zip archives, so this one has no direct URL.
    # Fetch it once by hand and drop the extracted TTF in util/fonts-src/:
    #   https://github.com/be5invis/Sarasa-Gothic/releases/download/v1.0.42/SarasaGothicSC-TTF-1.0.42.7z
    #   tar -xf SarasaGothicSC-TTF-1.0.42.7z SarasaGothicSC-Regular.ttf
    (
        "SarasaGothicSC-Regular.ttf",
        None,
        "sarasa-gothic-sc.woff2",
        "Sarasa Gothic SC",
        "400",
    ),
    (
        "MiSansVF.ttf",
        "https://raw.githubusercontent.com/dsrkafuu/misans/main/raw/Normal/MiSansVF.ttf",
        "misans.woff2",
        "MiSans",
        "100 900",
    ),
]

# Extra punctuation/symbols that may not be present in the currently rendered
# pages but are easy to need later (thin spaces, arrows, quotes, ...).
EXTRA = (
    " \t\n\r"
    "　"  # ideographic space
    "\u200a\u200b\u2002\u2003\u2014\u2018\u2019\u201c\u201d\u2026\u00b7"
    "\u2190\u2192\u2191\u2193\u21d2\u21d0\u00b1\u00d7\u00f7\u2248\u2260\u2264\u2265"
    "←→↑↓⇐⇒±×÷≈≠≤≥"
    "「」『』《》〈〉【】（）〔〕…—、。，！？：；·"
)


def download(url, dest):
    if os.path.exists(dest):
        return
    if url is None:
        sys.exit(f"missing {dest}; see the instructions in FONTS above")
    os.makedirs(os.path.dirname(dest), exist_ok=True)
    print(f"downloading {os.path.basename(dest)} ...")
    urllib.request.urlretrieve(url, dest)


def collect_characters():
    chars = set(string.printable)
    chars.update(EXTRA)
    for dirpath, _dirs, files in os.walk(SITE_DIR):
        for name in files:
            if not name.endswith(".html"):
                continue
            with open(os.path.join(dirpath, name), encoding="utf-8") as f:
                chars.update(f.read())
    return "".join(sorted(c for c in chars if c.strip() or c in EXTRA))


def main():
    os.makedirs(SRC_DIR, exist_ok=True)
    os.makedirs(OUT_DIR, exist_ok=True)

    text = collect_characters()
    text_file = os.path.join(SRC_DIR, "characters.txt")
    with open(text_file, "w", encoding="utf-8") as f:
        f.write(text)
    print(f"collected {len(text)} unique characters")

    for src_name, url, out_name, family, _weight in FONTS:
        src = os.path.join(SRC_DIR, src_name)
        download(url, src)
        out = os.path.join(OUT_DIR, out_name)
        args = [
            src,
            f"--text-file={text_file}",
            "--flavor=woff2",
            "--layout-features=*",
            "--drop-tables+=DSIG",
            "--name-IDs=*",
            f"--output-file={out}",
        ]
        subset.main(args)
        size = os.path.getsize(out)
        print(f"  {family:<18} -> {out_name}  {size/1024:.0f} KB")

    print("done.")


if __name__ == "__main__":
    sys.exit(main())
