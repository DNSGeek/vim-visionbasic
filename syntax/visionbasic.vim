" Vim syntax file
" Language:    Vision BASIC (compiled BASIC for the Commodore 64)
" URL:         https://www.visionbasic.net
" Generated:   from the C64 IDE VisionBASIC 1.1 plugin definition.
"              Token table extracted from VISION BASIC.VEX ($AC31);
"              keyword docs from the Vision BASIC Cheat Sheet.
" NOTE:        Generated file — regenerate rather than editing by hand.
scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif

" Vision BASIC listings are traditionally upper case, but accept either.
syntax case ignore
syntax sync minlines=50

" ─── Comments ────────────────────────────────────────────────────────────────
" A :syntax keyword always outranks a :syntax match, so REM is deliberately
" absent from the keyword groups below and handled as a region instead.
syntax region vbComment matchgroup=vbCommentKeyword start=/\<REM\>/ end=/$/ oneline contains=vbTodo
" ";" only starts a comment in machine-language context — in BASIC it is the
" PRINT separator, so match it after "]", on its own line, or inside [].
syntax match vbMLComment /^\s*;.*$/ contains=vbTodo
syntax match vbMLComment /\%(^\s*\d\+\s\+\)\@<=;.*$/ contains=vbTodo
syntax match vbMLComment /\%(\]\s*\)\@<=;.*$/ contains=vbTodo
syntax match vbMLComment contained /;.*$/ contains=vbTodo
syntax keyword vbTodo contained TODO FIXME NOTE XXX HACK

" ─── Strings and numbers ─────────────────────────────────────────────────────
syntax region vbString start=/"/ skip=/\\"/ end=/"/ oneline contains=vbPetscii
syntax match vbPetscii contained /{[^}]*}/
syntax match vbHexNumber /\$\x\+/
syntax match vbBinNumber /\%([[:alnum:]!@#%&?]\)\@<!%[01]\+\>/
syntax match vbNumber /\<\d\+\%(\.\d\+\)\=\>/
syntax match vbPi /\%d960/
" String variables. Defined before the keyword groups so that CHR$, LEFT$ and
" friends, which are matched later, take precedence.
syntax match vbStringVar /\<\a[[:alnum:]!@#%&?]*\$/
" Later definitions win in Vim, so the line number must come after vbNumber.
syntax match vbLineNumber /^\s*\d\+\ze\%(\s\|$\)/

" ─── Assembler blocks ────────────────────────────────────────────────────────
" Machine language lives inside [] brackets; ; starts an ML comment.
syntax region vbAsmBlock matchgroup=vbAsmDelimiter start=/\[/ end=/\]/ oneline contains=vbAsmMnemonic,vbAsmImmediate,vbHexNumber,vbBinNumber,vbNumber,vbMLComment,vbString
syntax keyword vbAsmMnemonic contained ADC AND ASL BCC BCS BEQ BIT BMI BNE BPL
  \ BRK BVC BVS CLC CLD CLI CLV CMP CPX CPY DEC DEX DEY EOR INC INX INY JMP
  \ JSR LDA LDX LDY LSR NOP ORA PHA PHP PLA PLP ROL ROR RTI RTS SBC SEC SED
  \ SEI STA STX STY TAX TAY TSX TXA TXS TYA
syntax match vbAsmImmediate contained /#/

" ─── Definitions and references ──────────────────────────────────────────────
" Vim matches syntax items left to right and never re-covers consumed text, so
" these use look-behind rather than \zs: the lead-in is another item already.
syntax match vbLabelDef /\%(\<DESC\s\+\d\+\s*,\s*\)\@<=\a[[:alnum:]!@#%&?]*/
syntax match vbLabelDef /\%(\<\%(TAG\|LABEL\|PROC\)\s\+\)\@<=\a[[:alnum:]!@#%&?]*/
syntax match vbProcCall /\<\a[[:alnum:]!@#%&?]*\ze\.[[:alnum:]$]/
syntax match vbLineRef /\%(\<\%(GOTO\|GOSUB\|THEN\|ELSE\)\s\+\)\@<=\d\+/

" ─── Not implemented by Vision BASIC ─────────────────────────────────────────
" These BASIC V2 functions are absent from Vision BASIC.
syntax keyword vbUnimplemented ATN COS EXP FRE LOG POS SIN SQR TAN USR

" ─── Assembler mode switches ───────────────────────────────────────────────────
syntax keyword vbAsmKeyword ASSEM BASIC LABEL START SYS

" ─── Editor & compiler commands ────────────────────────────────────────────────
syntax keyword vbEditKeyword AUTO COMP CONT DELETE DESC ERROR EXEC FIND HALT
  \ LIST LISTER LITE LLIST MODULE NEW OLD PLIST PREV QUIT RENUM RESUME RUN
  \ VLIST
syntax match vbEditKeyword /\<MODULE\s\+END/

" ─── IF / THEN / ELSE ──────────────────────────────────────────────────────────
syntax keyword vbConditional ELSE IF THEN

" ─── FOR / NEXT / TO / STEP / DO ───────────────────────────────────────────────
syntax keyword vbRepeat DO FOR NEXT STEP TO

" ─── Program flow ──────────────────────────────────────────────────────────────
syntax keyword vbStatement END GOSUB GOTO ON PASS POINT PROC RETURN SEND STOP
  \ TRAP TREND

" ─── Variable declaration & scope ──────────────────────────────────────────────
syntax keyword vbType CLR DECIMAL DEF DIM DUBL GLOBAL INTEGER LET LOCAL SUB
  \ TAG VARIABLES

" ─── Word operators ────────────────────────────────────────────────────────────
syntax keyword vbOperator AND EOR NOT OR

" ─── Math commands & functions ─────────────────────────────────────────────────
syntax keyword vbMathKeyword ABS ADD COMPARE DEC DOUBLE FN FRAC HALF INC INT
  \ JOIN RANDOM RND SGN SPLIT SUBTRACT WHOLE
syntax match vbMathKeyword /\<π/

" ─── String functions ──────────────────────────────────────────────────────────
syntax keyword vbStringFunc ASC LEN VAL
syntax match vbStringFunc /\<CHR\$/
syntax match vbStringFunc /\<DUP\$/
syntax match vbStringFunc /\<LEFT\$/
syntax match vbStringFunc /\<MID\$/
syntax match vbStringFunc /\<RIGHT\$/
syntax match vbStringFunc /\<STR\$/

" ─── Bitmap & sprite commands ──────────────────────────────────────────────────
syntax keyword vbGraphicsKeyword ALLMOBS BITMAP BMPCLR BMPCOL BMPLOC COLLISION
  \ DETECT HLINE LIMITS LINE MOB MOBCLR MOBCOL MOBEXP MOBPAT MOBSET MOBXY PLOT
  \ SHAPE VLINE

" ─── SID sound commands ────────────────────────────────────────────────────────
syntax keyword vbSoundKeyword ADSR CUTOFF FILTER FREQ PULSE SIDCLR VOICE VOL
  \ WAVE

" ─── Text screen commands ──────────────────────────────────────────────────────
syntax keyword vbScreenKeyword BLANK CATCH CHARPAT CHARSET CLS COLORS COPYSET
  \ EXTENDED LOC LOWERCASE MULTI NORMAL PANX PANY PRINT SPC TAB UPPERCASE
  \ VIDLOC

" ─── Memory & expansion RAM ────────────────────────────────────────────────────
syntax keyword vbMemoryKeyword BANK BYTES CODE COPY DETEXT FETCH FILL LONGPEEK
  \ LONGPOKE PEEK POKE REUPEEK REUPOKE STASH STRINGS SWAP SWITCH

" ─── Disk, file & input commands ───────────────────────────────────────────────
syntax keyword vbIOKeyword BUTTON CLOSE CMD DEVICE DIR DISK FILE GET GSAVE
  \ INPUT JOY KEYPRESS LOAD OPEN PADBUT PADDLE POLL SAVE STATUS VERIFY
syntax match vbIOKeyword /\<GET#/
syntax match vbIOKeyword /\<INPUT#/
syntax match vbIOKeyword /\<PRINT#/

" ─── System, timing & interrupts ───────────────────────────────────────────────
syntax keyword vbSystemKeyword CLOCK DATA DEBUG FAST HALTINT INTEND INTERRUPT
  \ PAUSE RASTER READ RESTORE SLOW STARTINT VERSION WAIT
syntax match vbSystemKeyword /\<POINT\s\+TAG/

" ─── ML-safe commands ────────────────────────────────────────────────────────
" Commands that remain usable inside an ASSEM block. Highlighting is provided
" by the groups above; the list is exposed for :help and for ftplugin use.
let b:visionbasic_ml_safe = ['START', 'GOTO', 'GOSUB', 'RETURN', 'REM', 'TAG', 'PROC', 'MODULE', 'LOCAL', 'GLOBAL', 'ADD', 'SUBTRACT', 'COMPARE', 'HALF', 'DOUBLE', 'VARIABLES', 'HALT', 'RESUME', 'VERSION', 'DEBUG', 'STARTINT', 'RASTER', 'BYTES', 'STRINGS']

" ─── Highlight links ─────────────────────────────────────────────────────────
highlight default link vbLineNumber    Number
highlight default link vbLineRef       Number
highlight default link vbComment       Comment
highlight default link vbCommentKeyword Comment
highlight default link vbMLComment     Comment
highlight default link vbTodo          Todo
highlight default link vbString        String
highlight default link vbStringVar     Identifier
highlight default link vbPetscii       SpecialChar
highlight default link vbHexNumber     Number
highlight default link vbBinNumber     Number
highlight default link vbNumber        Number
highlight default link vbPi            Constant
highlight default link vbAsmBlock      Normal
highlight default link vbAsmDelimiter  Delimiter
highlight default link vbAsmMnemonic   Operator
highlight default link vbAsmImmediate  Delimiter
highlight default link vbLabelDef      Function
highlight default link vbProcCall      Function
highlight default link vbUnimplemented Error
highlight default link vbAsmKeyword       PreProc
highlight default link vbEditKeyword      Keyword
highlight default link vbConditional      Conditional
highlight default link vbRepeat           Repeat
highlight default link vbStatement        Statement
highlight default link vbType             Type
highlight default link vbOperator         Operator
highlight default link vbMathKeyword      Function
highlight default link vbStringFunc       Function
highlight default link vbGraphicsKeyword  Special
highlight default link vbSoundKeyword     Special
highlight default link vbScreenKeyword    Special
highlight default link vbMemoryKeyword    Special
highlight default link vbIOKeyword        Keyword
highlight default link vbSystemKeyword    Special

" Legacy group names from earlier releases of this plugin.
highlight default link vbDiskKeyword      vbIOKeyword
highlight default link vbVarKeyword       vbType
highlight default link vbBitmapKeyword    vbGraphicsKeyword
highlight default link vbSpriteKeyword    vbGraphicsKeyword
highlight default link vbInterruptKeyword vbSystemKeyword
highlight default link vbVideoKeyword     vbScreenKeyword
highlight default link vbKeyword          vbStatement
highlight default link vbAsmSwitch        vbAsmKeyword
highlight default link vbSpecial          vbOperator

let b:current_syntax = 'visionbasic'
