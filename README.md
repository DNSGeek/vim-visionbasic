# vim-visionbasic

Vim syntax highlighting and filetype plugin for **Vision BASIC** — the enhanced
Commodore 64 BASIC environment by DNSGeek.

## Installation

### Manual

Copy the files into your Vim config directory:

```bash
cp syntax/visionbasic.vim ~/.vim/syntax/
cp ftplugin/visionbasic.vim ~/.vim/ftplugin/
```

### vim-plug / Vundle / Pathogen

Drop the whole `vim-visionbasic/` folder into your plugins directory,
or point your plugin manager at it if you put it on GitHub.

## Usage

Since `.bas` is a contested extension, filetype detection is **manual**:

```vim
:set filetype=visionbasic
```

Or add a modeline at the top of your file:

```
10 REM vim: set filetype=visionbasic :
```

Or add a permanent mapping to your `.vimrc` for convenience:

```vim
nnoremap <leader>vb :set filetype=visionbasic<CR>
```

## Features

### Syntax Highlighting

Distinct highlighting groups for:

| Group | Examples |
|---|---|
| Editing keywords | `LIST`, `RUN`, `COMP`, `RENUM` |
| Disk commands | `LOAD`, `SAVE`, `DIR`, `DISK` |
| Math functions | `ABS`, `INT`, `RND`, `RANDOM` |
| Speedy math | `INC`, `DEC`, `ADD`, `SUBTRACT` |
| Bitmap commands | `PLOT`, `LINE`, `HLINE`, `VLINE` |
| Sprite/MOB commands | `MOB`, `MOBXY`, `SHAPE`, `COLLISION` |
| Interrupt commands | `INTERRUPT`, `STARTINT`, `HALTINT` |
| SID sound commands | `VOICE`, `FREQ`, `ADSR`, `WAVE` |
| Text video commands | `COLORS`, `CHARSET`, `PANX`, `VIDLOC` |
| Assembler blocks | `[LDA #1: STA $D020]` highlighted separately |
| 6502 mnemonics | All standard 6502 opcodes inside `[]` |
| Strings | `"quoted strings"` |
| String variables | `NAME$`, `SCORE$` |
| Hex numbers | `$D020`, `$FF00` |
| Line numbers | Leading digits on each line |
| Comments | `REM ...` and `; ...` (ML mode) |

### Auto-Uppercase Keywords

When you leave insert mode (`<Esc>`), all Vision BASIC keywords on the
current line are automatically uppercased. Type naturally in lowercase,
get proper BASIC ALL-CAPS output. Very authentic.

### Comment Mode Toggle

Vision BASIC has two comment styles:
- **BASIC mode**: `REM this is a comment`
- **ML/Assembler mode**: `; this is a comment`

Toggle between them with `<LocalLeader>c` (default `\c`).

The current mode is shown in the status line. The plugin also gives you
a tip when your cursor lands on an `ASSEM` or `BASIC` keyword line.

Use with `vim-commentary` or similar for easy comment/uncomment that
respects whichever mode you're in.

## Vision BASIC Quirks (reminders)

- **No parentheses in math**: `A=3+4:A=A*4` not `A=4*(3+4)`
- **Strict left-to-right evaluation**: no operator precedence
- **Variable names**: max 8 characters, must start with a letter
- **Strings**: must end with `$`
- **All variables are integers by default** — use `DECIMAL` for floats
- **Assembler mode**: enter with `ASSEM`, exit with `BASIC`
- **ML mnemonics** go inside `[]` brackets
- **ML comments** use `;`, BASIC comments use `REM`

## License

MIT
