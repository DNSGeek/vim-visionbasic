# vim-visionbasic

Vim and Neovim support for [Vision BASIC](https://www.visionbasic.net) — Dennis
Osborn's compiled BASIC for the Commodore 64.

Everything here is derived from the VisionBASIC plugin definition shipped with
the C64 IDE: token values extracted from the table at `$AC31` in
`VISION BASIC.VEX`, keyword documentation from the Vision BASIC Cheat Sheet.
All **210 keywords** are covered, plus the 56 6502 mnemonics.

## Installation

With any plugin manager, point it at this directory:

```vim
" vim-plug
Plug 'DNSGeek/vim-visionbasic'
```

```lua
-- lazy.nvim
{ 'DNSGeek/vim-visionbasic' }
```

Or copy the tree into `~/.vim` (`~/.config/nvim` for Neovim) and run
`:helptags ~/.vim/doc`.

You need `filetype plugin indent on` and `syntax on` in your config.

## Filetype detection

`.bas` is contested — Visual Basic, QBasic, FreeBASIC, CBM BASIC and MMBasic all
claim it, and Vim and Neovim each ship a guess of their own. So a `.bas` file is
claimed **only when its contents look like Vision BASIC**: the first 100 lines
are scanned for a keyword that exists in Vision BASIC and essentially nowhere
else (`MOBXY`, `BMPCLR`, `HALTINT`, `REUPEEK`, `ASSEM`, `DESC 1000,NAME`, …).
`.vb64` and `.vbas` are claimed outright. A filetype you set yourself is never
overruled.

```vim
let g:visionbasic_claim_bas = 1   " always claim *.bas
let g:visionbasic_claim_bas = 0   " never sniff; leave *.bas alone
```

You can still set it by hand with `:setfiletype visionbasic`, or with a
modeline: `10 REM vim: set filetype=visionbasic :`

## Features

### Syntax highlighting

Every keyword, sorted into groups that link to standard highlight groups so they
follow your colour scheme:

| Group                                                 | Covers                                                                                 |
| ----------------------------------------------------- | -------------------------------------------------------------------------------------- |
| `vbEditKeyword`                                       | `LIST`, `RUN`, `COMP`, `RENUM`, `LISTER`, `MODULE`, `HALT`                             |
| `vbAsmKeyword`                                        | `ASSEM`, `BASIC`, `START`, `LABEL`, `SYS`                                              |
| `vbConditional` / `vbRepeat` / `vbStatement`          | `IF`/`THEN`/`ELSE`, `FOR`/`NEXT`/`DO`, `GOTO`/`PROC`/`PASS`/`SEND`                     |
| `vbType`                                              | `DECIMAL`, `DIM`, `DEF`, `TAG`, `LOCAL`, `GLOBAL`                                      |
| `vbMathKeyword` / `vbStringFunc`                      | `ABS`, `WHOLE`, `FRAC`, `INC`, `ADD`; `CHR$`, `MID$`, `DUP$`                           |
| `vbGraphicsKeyword`                                   | `PLOT`, `LINE`, `BITMAP`, `MOBXY`, `SHAPE`, `COLLISION`                                |
| `vbSoundKeyword`                                      | `VOICE`, `FREQ`, `ADSR`, `WAVE`, `SIDCLR`                                              |
| `vbScreenKeyword` / `vbMemoryKeyword` / `vbIOKeyword` | `COLORS`, `CHARSET`, `PANX`; `STASH`, `FETCH`, `REUPEEK`; `LOAD`, `DISK`, `JOY`        |
| `vbSystemKeyword`                                     | `INTERRUPT`, `STARTINT`, `HALTINT`, `RASTER`, `PAUSE`                                  |
| `vbUnimplemented`                                     | `SQR`, `SIN`, `COS`, `LOG`, `USR`, … flagged as errors — Vision BASIC has none of them |

Plus assembler blocks (`[LDA #1: STA $D020]` with 6502 mnemonics highlighted
separately), `$D020` hex and `%10101010` binary literals, `{CLR}` PETSCII escapes
inside strings, string variables, tag and `PROC` definitions, named subroutine
calls (`DRAWBOX.X,Y`), and line numbers — both the leading number and the
`GOTO`/`GOSUB` targets that reference it.

Comments are handled properly in both modes: `REM` swallows the rest of the line
(so a keyword mentioned in a comment is not highlighted as code), and `;` only
starts a comment where machine language is actually in play — never where it is
the `PRINT` separator.

### Keyword documentation

Press `K` on any keyword — or run `:VBDoc MOBXY` — for the full entry in a
preview window: syntax, description, a parameter table with valid ranges, an
example, and the contextual warnings that matter (`VOICE` before
`FREQ`/`ADSR`/`WAVE`, `HALTINT` before exit, the no-parentheses math rule,
the 8-character variable limit, whether the command is ML-safe).

`:help visionbasic` has the same reference, with a tag per keyword —
`:help visionbasic-MOBXY`.

### Completion

`'omnifunc'` is set, so `CTRL-X CTRL-O` completes Vision BASIC keywords with the
syntax line in the menu and the full entry in the preview window. Inside a
`[...]` block it completes 6502 mnemonics instead.

### Line numbering

| Command                      | Does                                         |
| ---------------------------- | -------------------------------------------- |
| `:VBNumber [start] [step]`   | Number the unnumbered lines in a range       |
| `:VBRenumber [start] [step]` | Renumber the file and follow every reference |

`:VBRenumber` knows which arguments are actually line numbers: all of them after
`GOTO`, `GOSUB`, `THEN` and `ELSE` (including `ON A GOTO 10,20,30`), the first
after `DESC`, `TRAP` and `DO`, the **second** after `INTERRUPT` (the first is a
raster line), and the target of `POINT`. Text inside `REM` and `;` comments is
left alone.

### Auto-uppercase

Vision BASIC listings are upper case. Type in lower case; on leaving insert mode
the keywords and mnemonics on the line are folded up, leaving strings, comments
and your own variable names exactly as typed.

```vim
let g:visionbasic_auto_uppercase = 0   " turn it off
```

`:VBUppercase` applies the same pass to a range on demand.

### Comment mode

`<LocalLeader>c` (or `:VBCommentMode`) toggles `'commentstring'` between
`REM %s` and `; %s`, so `vim-commentary` and friends insert the right one for
the mode you are in. Show it in your statusline with
`%{visionbasic#mode()}`.

### Snippets

`UltiSnips/` and `snippets/` (SnipMate) each carry 30 snippets — `for`, `proc`,
`interrupt`, `mob`, `sound`, `bitmap`, `assem`, `module`, `reu`, `trap`,
`openread` and more.

### matchit

With `matchit` loaded, `%` jumps between `FOR`/`NEXT`, `PROC`/`RETURN`,
`STARTINT`/`INTEND`, `LOCAL`/`GLOBAL`, `ASSEM`/`BASIC` and
`MODULE`/`MODULE END`.

## Vision BASIC quirks

- **No parentheses in math**, and no operator precedence — strictly left to
  right. `4+3*5-2*6` is `(((4+3)*5)-2)*6` = 198.
- **Variable names** start with a letter and are significant to 8 characters;
  `!@#%&?` and digits are allowed. A name may contain a keyword but may not
  start with one.
- **Everything is an integer** unless declared `DECIMAL`. Strings end in `$`.
- **Machine language** is entered with `ASSEM` and left with `BASIC`; mnemonics
  go in `[]`, statements inside them are separated by `:`, and `;` starts a
  comment. Branches and jumps may target a BASIC line number directly
  (`JMP1000`).
- **Always `HALTINT`** before exiting a program that uses raster interrupts.
- `USR`, `FRE`, `POS`, `SQR`, `LOG`, `EXP`, `COS`, `SIN`, `TAN` and `ATN` are
  **not implemented**.

## Regenerating

See [tools/README.md](tools/README.md). The syntax, autoload and help files are
generated from the C64 IDE plugin definition — edit the generators, not the
output.

## License

MIT
