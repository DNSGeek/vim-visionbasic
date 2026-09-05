"""Generate vim snippet files from the shared VS Code snippet definitions."""

import json
import os
import re
import sys

REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# The VS Code extension owns the snippet definitions; these are converted from
# it so the two editors stay in step. Override with --snippets PATH.
DEFAULT_SRC = os.path.join(
    os.path.dirname(REPO), "vscode-visionbasic", "snippets", "visionbasic.json"
)
SRC = (
    sys.argv[sys.argv.index("--snippets") + 1]
    if "--snippets" in sys.argv
    else os.environ.get("VISIONBASIC_SNIPPETS", DEFAULT_SRC)
)
ULTI = REPO + "/UltiSnips/visionbasic.snippets"
SNIPMATE = REPO + "/snippets/visionbasic.snippets"

HEADER = [
    "# Vision BASIC snippets.",
    "# Generated from the shared snippet definitions used by the VS Code",
    "# extension; regenerate rather than editing by hand.",
    "",
]

# Neither UltiSnips nor SnipMate understands ${1|a,b|} choice placeholders.
CHOICE = re.compile(r"\$\{(\d+)\|([^|}]*)\|\}")


def convert(line):
    line = CHOICE.sub(
        lambda m: "${%s:%s}" % (m.group(1), m.group(2).split(",")[0]), line
    )
    return line.replace("\\$", "$")


if not os.path.exists(SRC):
    raise SystemExit("Snippet definitions not found: %s\nPass --snippets PATH." % SRC)
snippets = json.load(open(SRC))
ordered = sorted(snippets.items(), key=lambda kv: kv[1]["prefix"])

ulti = list(HEADER)
for name, snip in ordered:
    ulti.append(
        'snippet %s "%s" b' % (snip["prefix"], snip["description"].replace('"', "'"))
    )
    for line in snip["body"]:
        ulti.append(convert(line))
    ulti.append("endsnippet")
    ulti.append("")

snipmate = list(HEADER)
for name, snip in ordered:
    snipmate.append("snippet %s %s" % (snip["prefix"], snip["description"]))
    for line in snip["body"]:
        snipmate.append("\t" + convert(line))
    snipmate.append("")

for path, lines in ((ULTI, ulti), (SNIPMATE, snipmate)):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as fh:
        fh.write("\n".join(lines).rstrip() + "\n")
    print("wrote", path, len(lines), "lines")
