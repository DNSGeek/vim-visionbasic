"""Generate vim-visionbasic/syntax/visionbasic.vim from the plugin database."""

import os
import re
import sys
import textwrap

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
REPO = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
import vbdb

OUT = REPO + "/syntax/visionbasic.vim"

# group id -> (syntax group, default highlight link, comment)
GROUPS = {
    "assembler": ("vbAsmKeyword", "PreProc", "Assembler mode switches"),
    "editor": ("vbEditKeyword", "Keyword", "Editor & compiler commands"),
    "conditional": ("vbConditional", "Conditional", "IF / THEN / ELSE"),
    "loop": ("vbRepeat", "Repeat", "FOR / NEXT / TO / STEP / DO"),
    "flow": ("vbStatement", "Statement", "Program flow"),
    "variable": ("vbType", "Type", "Variable declaration & scope"),
    "operator": ("vbOperator", "Operator", "Word operators"),
    "math": ("vbMathKeyword", "Function", "Math commands & functions"),
    "string": ("vbStringFunc", "Function", "String functions"),
    "graphics": ("vbGraphicsKeyword", "Special", "Bitmap & sprite commands"),
    "sound": ("vbSoundKeyword", "Special", "SID sound commands"),
    "screen": ("vbScreenKeyword", "Special", "Text screen commands"),
    "memory": ("vbMemoryKeyword", "Special", "Memory & expansion RAM"),
    "io": ("vbIOKeyword", "Keyword", "Disk, file & input commands"),
    "system": ("vbSystemKeyword", "Special", "System, timing & interrupts"),
}

# Kept so existing colour-scheme overrides do not break.
LEGACY_LINKS = [
    ("vbDiskKeyword", "vbIOKeyword"),
    ("vbVarKeyword", "vbType"),
    ("vbBitmapKeyword", "vbGraphicsKeyword"),
    ("vbSpriteKeyword", "vbGraphicsKeyword"),
    ("vbInterruptKeyword", "vbSystemKeyword"),
    ("vbVideoKeyword", "vbScreenKeyword"),
    ("vbKeyword", "vbStatement"),
    ("vbAsmSwitch", "vbAsmKeyword"),
    ("vbSpecial", "vbOperator"),
]

db = vbdb.load()
L = []
w = L.append


def wrap_keywords(command, names, width=78):
    """`syntax keyword vbFoo A B C` folded onto continuation lines."""
    line = command
    out = []
    for n in names:
        if len(line) + 1 + len(n) > width and line != command:
            out.append(line)
            line = "  \\ " + n
        else:
            line = line + " " + n if line != command else command + " " + n
    out.append(line)
    return out


w('" Vim syntax file')
w('" Language:    Vision BASIC (compiled BASIC for the Commodore 64)')
w('" URL:         %s' % db["url"])
w('" Generated:   from the C64 IDE VisionBASIC %s plugin definition.' % db["version"])
w('"              Token table extracted from VISION BASIC.VEX ($AC31);')
w('"              keyword docs from the Vision BASIC Cheat Sheet.')
w('" NOTE:        Generated file — regenerate rather than editing by hand.')
w("scriptencoding utf-8")
w("")
w("if exists('b:current_syntax')")
w("  finish")
w("endif")
w("")
w('" Vision BASIC listings are traditionally upper case, but accept either.')
w("syntax case ignore")
w("syntax sync minlines=50")
w("")

w('" ─── Comments ────────────────────────────────────────────────────────────────')
w('" A :syntax keyword always outranks a :syntax match, so REM is deliberately')
w('" absent from the keyword groups below and handled as a region instead.')
w(
    r"syntax region vbComment matchgroup=vbCommentKeyword start=/\<REM\>/ end=/$/ oneline contains=vbTodo"
)
w('" ";" only starts a comment in machine-language context — in BASIC it is the')
w('" PRINT separator, so match it after "]", on its own line, or inside [].')
w(r"syntax match vbMLComment /^\s*;.*$/ contains=vbTodo")
w(r"syntax match vbMLComment /\%(^\s*\d\+\s\+\)\@<=;.*$/ contains=vbTodo")
w(r"syntax match vbMLComment /\%(\]\s*\)\@<=;.*$/ contains=vbTodo")
w(r"syntax match vbMLComment contained /;.*$/ contains=vbTodo")
w("syntax keyword vbTodo contained TODO FIXME NOTE XXX HACK")
w("")

w('" ─── Strings and numbers ─────────────────────────────────────────────────────')
w(r'syntax region vbString start=/"/ skip=/\\"/ end=/"/ oneline contains=vbPetscii')
w(r"syntax match vbPetscii contained /{[^}]*}/")
w(r"syntax match vbHexNumber /\$\x\+/")
w(r"syntax match vbBinNumber /\%([[:alnum:]!@#%&?]\)\@<!%[01]\+\>/")
w(r"syntax match vbNumber /\<\d\+\%(\.\d\+\)\=\>/")
w(r"syntax match vbPi /\%d960/")
w('" String variables. Defined before the keyword groups so that CHR$, LEFT$ and')
w('" friends, which are matched later, take precedence.')
w(r"syntax match vbStringVar /\<\a[[:alnum:]!@#%&?]*\$/")
w('" Later definitions win in Vim, so the line number must come after vbNumber.')
w(r"syntax match vbLineNumber /^\s*\d\+\ze\%(\s\|$\)/")
w("")

w('" ─── Assembler blocks ────────────────────────────────────────────────────────')
w('" Machine language lives inside [] brackets; ; starts an ML comment.')
w(
    "syntax region vbAsmBlock matchgroup=vbAsmDelimiter start=/\\[/ end=/\\]/ oneline"
    " contains=vbAsmMnemonic,vbAsmImmediate,vbHexNumber,vbBinNumber,vbNumber,vbMLComment,vbString"
)
for line in wrap_keywords(
    "syntax keyword vbAsmMnemonic contained", sorted(db["mnemonics"])
):
    w(line)
w(r"syntax match vbAsmImmediate contained /#/")
w("")

w('" ─── Definitions and references ──────────────────────────────────────────────')
w('" Vim matches syntax items left to right and never re-covers consumed text, so')
w('" these use look-behind rather than \\zs: the lead-in is another item already.')
w(r"syntax match vbLabelDef /\%(\<DESC\s\+\d\+\s*,\s*\)\@<=\a[[:alnum:]!@#%&?]*/")
w(r"syntax match vbLabelDef /\%(\<\%(TAG\|LABEL\|PROC\)\s\+\)\@<=\a[[:alnum:]!@#%&?]*/")
w(r"syntax match vbProcCall /\<\a[[:alnum:]!@#%&?]*\ze\.[[:alnum:]$]/")
w(r"syntax match vbLineRef /\%(\<\%(GOTO\|GOSUB\|THEN\|ELSE\)\s\+\)\@<=\d\+/")
w("")

w('" ─── Not implemented by Vision BASIC ─────────────────────────────────────────')
unimpl = sorted(k["keyword"] for k in db["keywords"] if k.get("unimplemented"))
w('" These BASIC V2 functions are absent from Vision BASIC.')
for line in wrap_keywords("syntax keyword vbUnimplemented", unimpl):
    w(line)
w("")

for gid, label, members in vbdb.groups(db):
    group, _link, comment = GROUPS[gid]
    names = [
        k["keyword"]
        for k in members
        if not k.get("unimplemented")
        and not k.get("fragment")
        and k["keyword"] != "REM"
    ]
    plain = sorted(
        vbdb.display(n) for n in names if vbdb.plain(vbdb.display(n)) and " " not in n
    )
    odd = sorted(n for n in names if not (vbdb.plain(vbdb.display(n)) and " " not in n))
    if not plain and not odd:
        continue
    w('" ─── %s ' % comment + "─" * max(3, 74 - len(comment)))
    if plain:
        for line in wrap_keywords("syntax keyword %s" % group, plain):
            w(line)
    for n in odd:
        # CHR$, GET#, MODULE END, POINT TAG, SPC( ...
        pat = re.escape(vbdb.display(n)).replace("\\ ", r"\s\+")
        pat = pat.replace("\\$", r"\$").replace("\\#", "#")
        if re.fullmatch(r"[A-Za-z]+", vbdb.display(n)):
            tail = r"\>"
        else:
            tail = ""
        w(r"syntax match %s /\<%s%s/" % (group, pat, tail))
    w("")

w('" ─── ML-safe commands ────────────────────────────────────────────────────────')
w('" Commands that remain usable inside an ASSEM block. Highlighting is provided')
w('" by the groups above; the list is exposed for :help and for ftplugin use.')
w("let b:visionbasic_ml_safe = [%s]" % ", ".join("'%s'" % k for k in db["mlSafe"]))
w("")

w('" ─── Highlight links ─────────────────────────────────────────────────────────')
w("highlight default link vbLineNumber    Number")
w("highlight default link vbLineRef       Number")
w("highlight default link vbComment       Comment")
w("highlight default link vbCommentKeyword Comment")
w("highlight default link vbMLComment     Comment")
w("highlight default link vbTodo          Todo")
w("highlight default link vbString        String")
w("highlight default link vbStringVar     Identifier")
w("highlight default link vbPetscii       SpecialChar")
w("highlight default link vbHexNumber     Number")
w("highlight default link vbBinNumber     Number")
w("highlight default link vbNumber        Number")
w("highlight default link vbPi            Constant")
w("highlight default link vbAsmBlock      Normal")
w("highlight default link vbAsmDelimiter  Delimiter")
w("highlight default link vbAsmMnemonic   Operator")
w("highlight default link vbAsmImmediate  Delimiter")
w("highlight default link vbLabelDef      Function")
w("highlight default link vbProcCall      Function")
w("highlight default link vbUnimplemented Error")
for gid in GROUPS:
    group, link, _ = GROUPS[gid]
    w("highlight default link %-18s %s" % (group, link))
w("")
w('" Legacy group names from earlier releases of this plugin.')
for old, new in LEGACY_LINKS:
    w("highlight default link %-18s %s" % (old, new))
w("")
w("let b:current_syntax = 'visionbasic'")

with open(OUT, "w") as fh:
    fh.write("\n".join(L) + "\n")
print("wrote", OUT, len(L), "lines")
