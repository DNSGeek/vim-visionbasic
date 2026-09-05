# Generators

`syntax/visionbasic.vim`, `autoload/visionbasic.vim` and `doc/visionbasic.txt`
are derived from one source of truth: the **VisionBASIC plugin definition
shipped with the C64 IDE** (`Resources/Plugins/VisionBASIC_1.1.c64basic`). Its
token values come from the table at `$AC31` in `VISION BASIC.VEX`; its
documentation comes from the Vision BASIC Cheat Sheet.

Regenerate after updating that definition — do not hand-edit the generated
files:

```bash
python3 tools/gen_syntax.py   --plugin /path/to/VisionBASIC_1.1.c64basic
python3 tools/gen_autoload.py --plugin /path/to/VisionBASIC_1.1.c64basic
python3 tools/gen_doc.py      --plugin /path/to/VisionBASIC_1.1.c64basic
python3 tools/gen_snippets.py
```

The plugin path can also come from `$VISIONBASIC_PLUGIN`, or from `DEFAULT_SRC`
in `vbdb.py`.

| Script            | Writes                                                                            |
| ----------------- | --------------------------------------------------------------------------------- |
| `gen_syntax.py`   | `syntax/visionbasic.vim`                                                          |
| `gen_autoload.py` | `autoload/visionbasic.vim` — keyword database, `K` docs, completion, case folding |
| `gen_doc.py`      | `doc/visionbasic.txt` — run `:helptags doc` afterwards                            |
| `gen_snippets.py` | `UltiSnips/visionbasic.snippets` and `snippets/visionbasic.snippets`              |

`gen_snippets.py` converts the snippet definitions owned by the [VS Code
extension](../../vscode-visionbasic) (`snippets/visionbasic.json`) so both
editors offer the same set. It looks for a sibling `vscode-visionbasic`
checkout by default; override with `--snippets PATH` or
`$VISIONBASIC_SNIPPETS`.

`ftplugin/`, `ftdetect/` and `indent/` are hand-written.
