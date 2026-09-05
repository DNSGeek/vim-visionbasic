"""Generate vim-visionbasic/doc/visionbasic.txt from the plugin database."""

import os
import sys
import textwrap

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
import vbdb

OUT = REPO + "/doc/visionbasic.txt"
W = 78

db = vbdb.load()
L = []
w = L.append


def rule(char="="):
    w(char * W)


def head(title, tag):
    rule()
    w("%-*s%s" % (W - len(tag) - 2, title, "*" + tag + "*"))
    w("")


def para(text, indent=""):
    for line in textwrap.wrap(text, W, initial_indent=indent, subsequent_indent=indent):
        w(line)


w("*visionbasic.txt*  Vision BASIC support for Vim — the compiled BASIC for the C64")
w("")
w("                    VISION BASIC — REFERENCE MANUAL")
w("")
para(
    "Syntax highlighting, keyword documentation, completion and line-number "
    "tooling for Vision BASIC %s by Dennis Osborn. %s" % (db["version"], db["url"])
)
w("")
para(
    "Keyword reference generated from the C64 IDE VisionBASIC plugin definition: "
    "token values from the table at $AC31 in VISION BASIC.VEX, documentation from "
    "the Vision BASIC Cheat Sheet."
)
w("")
w("CONTENTS                                              *visionbasic-contents*")
w("")
w("  1. Filetype detection ............... |visionbasic-detection|")
w("  2. Commands ......................... |visionbasic-commands|")
w("  3. Mappings ......................... |visionbasic-mappings|")
w("  4. Options .......................... |visionbasic-options|")
w("  5. Completion ....................... |visionbasic-completion|")
w("  6. Highlight groups ................. |visionbasic-highlight|")
w("  7. Language quirks .................. |visionbasic-quirks|")
w("  8. Keyword reference ................ |visionbasic-keywords|")
w("")

head("1. Filetype detection", "visionbasic-detection")
para(
    "Vision BASIC sources normally use the .bas extension, which is also claimed "
    "by Visual Basic, QBasic, FreeBASIC, CBM BASIC and others — and both Vim and "
    "Neovim ship a guess of their own for it. So a .bas file is only claimed when "
    "its first 100 lines contain a keyword that exists in Vision BASIC and "
    "essentially nowhere else (MOBXY, BMPCLR, HALTINT, REUPEEK, ASSEM and the "
    "like). The .vb64 and .vbas extensions are claimed outright."
)
w("")
para(
    "A filetype you chose yourself — in a modeline or by hand — is never "
    "overruled; only Vim's own generic BASIC guesses are."
)
w("")
w("                                                *g:visionbasic_claim_bas*")
w("To take over every .bas file regardless of content: >")
w("")
w("    let g:visionbasic_claim_bas = 1")
w("<")
w("To leave .bas files entirely alone: >")
w("")
w("    let g:visionbasic_claim_bas = 0")
w("<")
w("Either way you can always set the filetype by hand: >")
w("")
w("    :setfiletype visionbasic")
w("<")
w("or with a modeline in the listing itself: >")
w("")
w("    10 REM vim: set filetype=visionbasic :")
w("<")

head("2. Commands", "visionbasic-commands")
for name, args, desc in [
    (
        ":VBDoc",
        "[{keyword}]",
        "Show the reference entry for {keyword}, or for the word under the cursor, "
        "in a preview window. Completes on every Vision BASIC keyword and 6502 "
        "mnemonic.",
    ),
    (
        ":VBCommentMode",
        "",
        "Toggle 'commentstring' between REM (BASIC mode) and ; (machine language "
        "mode). Vision BASIC uses both, and 'commentstring' can only hold one.",
    ),
    (
        ":VBNumber",
        "[{start}] [{step}]",
        "Add line numbers to the unnumbered lines in the range, starting at {start} "
        "(default 10) and counting up by {step} (default 10). Lines that already "
        "carry a number are left alone. Defaults to the whole file.",
    ),
    (
        ":VBRenumber",
        "[{start}] [{step}]",
        "Renumber every numbered line in the buffer and follow the references: "
        "GOTO, GOSUB, THEN and ELSE targets, the line numbers of DESC, TRAP and DO, "
        "the second argument of INTERRUPT (the first is a raster line, not a line "
        "number) and the target of POINT. Text inside REM and ; comments is left "
        "untouched.",
    ),
    (
        ":VBUppercase",
        "",
        "Fold the Vision BASIC keywords and 6502 mnemonics in the range up to "
        "upper case, leaving string literals, comments and your own variable names "
        "alone. Defaults to the whole file.",
    ),
]:
    tag = "*%s*" % name
    w("%-*s%s" % (W - len(tag), (name + " " + args).rstrip(), tag))
    para(desc, "    ")
    w("")

head("3. Mappings", "visionbasic-mappings")
w("K                       Show the reference entry for the keyword under the")
w("                        cursor (see |:VBDoc|). Only mapped if you have not")
w("                        already mapped K yourself.")
w("")
w("<LocalLeader>c          Toggle BASIC/ML comment mode (see |:VBCommentMode|).")
w("")
w("<LocalLeader>u          Upper-case the keywords in the buffer (|:VBUppercase|).")
w("")
para(
    "With 'matchit' loaded, % jumps between FOR/NEXT, PROC/RETURN, "
    "STARTINT/INTEND, LOCAL/GLOBAL, ASSEM/BASIC and MODULE/MODULE END."
)
w("")

head("4. Options", "visionbasic-options")
w("                                          *g:visionbasic_auto_uppercase*")
para(
    "Vision BASIC listings are traditionally upper case. By default, leaving "
    "insert mode folds the keywords on the current line up to upper case — type "
    "in lower case, get a proper listing. Strings, comments and your own "
    "identifiers are left as typed. To turn this off: >"
)
w("")
w("    let g:visionbasic_auto_uppercase = 0")
w("<")
para("|:VBUppercase| still works when the automatic pass is disabled.")
w("")
w("                                          *visionbasic-statusline*")
w("The current comment mode is available for a statusline: >")
w("")
w("    set statusline+=%{visionbasic#mode()}")
w("<")

head("5. Completion", "visionbasic-completion")
para(
    "'omnifunc' is set to visionbasic#complete, so CTRL-X CTRL-O completes "
    "Vision BASIC keywords, with the syntax line in the popup menu and the full "
    "reference entry in the preview window. Inside a [...] machine language "
    "block it completes 6502 mnemonics instead."
)
w("")
para(
    "Keywords Vision BASIC does not implement — the BASIC V2 leftovers USR, FRE, "
    'POS, SQR, LOG, EXP, COS, SIN, TAN and ATN — are marked "x" in the menu.'
)
w("")

head("6. Highlight groups", "visionbasic-highlight")
para(
    "Every group links to a standard group by default, so it follows your colour "
    "scheme. Override any of them with :highlight link."
)
w("")
for group, what in [
    ("vbLineNumber", "leading line number of a listing line"),
    ("vbLineRef", "line number used as a GOTO/GOSUB/THEN/ELSE target"),
    ("vbComment", "REM comment"),
    ("vbMLComment", "; comment in machine language context"),
    ("vbString", "string literal"),
    ("vbPetscii", "{...} PETSCII escape inside a string"),
    ("vbStringVar", "string variable (NAME$)"),
    ("vbHexNumber", "$D020"),
    ("vbBinNumber", "%10101010"),
    ("vbAsmBlock", "[...] machine language block"),
    ("vbAsmMnemonic", "6502 mnemonic inside a block"),
    ("vbAsmDelimiter", "the [ and ] themselves"),
    ("vbLabelDef", "name introduced by DESC, TAG, LABEL or PROC"),
    ("vbProcCall", "named subroutine call (DRAWBOX.X,Y)"),
    ("vbUnimplemented", "BASIC V2 keyword Vision BASIC does not implement"),
    ("vbEditKeyword", "editor and compiler commands"),
    ("vbAsmKeyword", "ASSEM, BASIC, START, LABEL, SYS"),
    ("vbConditional", "IF, THEN, ELSE"),
    ("vbRepeat", "FOR, NEXT, TO, STEP, DO"),
    ("vbStatement", "program flow"),
    ("vbType", "variable declaration and scope"),
    ("vbOperator", "AND, OR, EOR, NOT"),
    ("vbMathKeyword", "math commands and functions"),
    ("vbStringFunc", "string functions"),
    ("vbGraphicsKeyword", "bitmap and sprite commands"),
    ("vbSoundKeyword", "SID commands"),
    ("vbScreenKeyword", "text screen commands"),
    ("vbMemoryKeyword", "memory and expansion RAM commands"),
    ("vbIOKeyword", "disk, file and input commands"),
    ("vbSystemKeyword", "system, timing and interrupt commands"),
]:
    w("  %-20s %s" % (group, what))
w("")

head("7. Language quirks", "visionbasic-quirks")
para(db["notes"]["math"].replace("`", ""))
w("")
para(db["notes"]["variables"].replace("`", ""))
w("")
para(
    "Machine language is entered with ASSEM and left with BASIC. Mnemonics are "
    'wrapped in [] brackets, statements inside them are separated by ":", and '
    '";" starts a comment. Branches and jumps may target a BASIC line number '
    "directly, e.g. JMP1000."
)
w("")
para("These commands stay usable inside an ASSEM block:")
w("")
for i in range(0, len(db["mlSafe"]), 8):
    w("  " + ", ".join(db["mlSafe"][i : i + 8]))
w("")
para(
    "VOICE must be called before FREQ, PULSE, ADSR and WAVE — they all act on "
    "the current voice."
)
w("")
para(
    "Always HALTINT before your program exits, or the machine is left running "
    "your raster interrupt."
)
w("")
para("Strings and string variables cannot be returned from subroutines.")
w("")

head("8. Keyword reference", "visionbasic-keywords")
para("Every entry is also reachable from the buffer with K or |:VBDoc|.")
w("")
GROUP_LABEL = {gid: label for gid, label, _ in vbdb.groups(db)}
for gid, label, members in vbdb.groups(db):
    w("")
    rule("-")
    w(label.upper())
    rule("-")
    for kw in sorted(members, key=lambda k: k["keyword"]):
        if kw.get("fragment"):
            continue
        name = vbdb.display(kw["keyword"])
        tag = "*visionbasic-%s*" % name
        w("")
        w("%-*s%s" % (max(1, W - len(tag)), kw.get("syntax", name), tag))
        para(kw.get("description", ""), "    ")
        if kw.get("parameters"):
            w("")
            for p in kw["parameters"]:
                label_ = p["name"] + (" (optional)" if p.get("optional") else "")
                rng = p.get("range") or p.get("type") or ""
                w("      %-16s %s" % (label_, rng))
                if p.get("description"):
                    para(p["description"], "        ")
        if kw.get("example"):
            w("")
            w("    Example: " + kw["example"])
        if kw.get("notes"):
            w("")
            para(kw["notes"], "    ")
        if kw.get("warning"):
            w("")
            para("Note: " + kw["warning"], "    ")
        if kw.get("unimplemented"):
            w("")
            para("Note: not implemented by Vision BASIC.", "    ")
        if kw.get("mlSafe"):
            w("")
            para("ML-safe: usable inside an ASSEM block.", "    ")
w("")
rule()
w("vim:tw=78:ts=8:noet:ft=help:norl:")

os.makedirs(os.path.dirname(OUT), exist_ok=True)
with open(OUT, "w") as fh:
    fh.write("\n".join(L) + "\n")
print("wrote", OUT, len(L), "lines")
