" Vim syntax file
" Language:    Vision BASIC (C64 enhanced BASIC)
" Maintainer:  Tom
" Last Change: 2026
" Based on:    DNSGeek Vision BASIC Cheat Sheet

if exists('b:current_syntax')
  finish
endif

" Case insensitive matching
syntax case ignore

" ─── Line Numbers ────────────────────────────────────────────────────────────
syntax match vbLineNumber /^\s*\d\+/ contained
syntax region vbLine start=/^\s*\d/ end=/$/ contains=vbLineNumber,@vbCode

" ─── Comments ────────────────────────────────────────────────────────────────
" REM comment (BASIC mode) - rest of line
syntax match vbComment /\<REM\>.*$/ contains=vbTodo
" Semicolon comment (ML/assembler mode) - rest of line after ;
syntax match vbMLComment /;.*$/ contains=vbTodo
syntax keyword vbTodo TODO FIXME NOTE contained

" ─── Assembler Mode Block ────────────────────────────────────────────────────
" Mnemonics inside [] brackets
syntax region vbAsmBlock start=/\[/ end=/\]/ contains=vbAsmMnemonic,vbMLComment,vbNumber,vbHexNumber
syntax keyword vbAsmMnemonic contained
  \ ADC AND ASL BCC BCS BEQ BIT BMI BNE BPL BRK BVC BVS
  \ CLC CLD CLI CLV CMP CPX CPY DEC DEX DEY EOR INC INX INY
  \ JMP JSR LDA LDX LDY LSR NOP ORA PHA PHP PLA PLP
  \ ROL ROR RTI RTS SBC SEC SED SEI STA STX STY
  \ TAX TAY TSX TXA TXS TYA

" ASSEM / BASIC mode switches
syntax keyword vbAsmSwitch ASSEM BASIC

" ─── Strings ─────────────────────────────────────────────────────────────────
syntax region vbString start=/"/ end=/"/ oneline

" ─── Numbers ─────────────────────────────────────────────────────────────────
syntax match vbHexNumber /\$[0-9A-Fa-f]\+/
syntax match vbNumber /\b\d\+\b/

" ─── Variables ───────────────────────────────────────────────────────────────
" String variables (end with $)
syntax match vbStringVar /\b[A-Za-z][A-Za-z0-9!@#%&?]\{0,6\}\$/
" Tags / labels (used with TAG, DESC, LABEL)
syntax match vbTag /\b[A-Za-z][A-Za-z0-9!@#%&?]\{0,7\}\b/ contained

" ─── Editing Keywords ────────────────────────────────────────────────────────
syntax keyword vbEditKeyword
  \ ASSEM BANK BASIC COMP DELETE DESC ERROR EXEC FAST FIND
  \ LIST LISTER LITE LLIST NEW OLD PLIST QUIT RENUM RUN
  \ SLOW VLIST

" ─── Disk / File Commands ────────────────────────────────────────────────────
syntax keyword vbDiskKeyword
  \ DEVICE DIR DISK GSAVE LOAD SAVE VERIFY

" ─── Variable Keywords ───────────────────────────────────────────────────────
syntax keyword vbVarKeyword
  \ CLR DECIMAL DIM GLOBAL LET LOCAL TAG VARIABLES

" ─── Math Keywords ───────────────────────────────────────────────────────────
syntax keyword vbMathKeyword
  \ ABS AND OR EOR INT SGN WHOLE FRAC RANDOM RND
  \ ADD COMPARE DEC DOUBLE HALF INC SUBTRACT

" ─── Bitmap Commands ─────────────────────────────────────────────────────────
syntax keyword vbBitmapKeyword
  \ BITMAP BMPCLR BMPCOL BMPLOC HLINE LIMITS LINE PLOT VLINE

" ─── Sprite / MOB Commands ───────────────────────────────────────────────────
syntax keyword vbSpriteKeyword
  \ ALLMOBS CODE COLLISION DETECT MOB MOBCLR MOBCOL MOBEXP
  \ MOBPAT MOBSET MOBXY SHAPE

" ─── Interrupt Commands ──────────────────────────────────────────────────────
syntax keyword vbInterruptKeyword
  \ HALTINT INTEND INTERRUPT RASTER STARTINT

" ─── Sound / SID Commands ────────────────────────────────────────────────────
syntax keyword vbSoundKeyword
  \ ADSR CUTOFF FILTER FREQ PULSE SIDCLR VOICE VOL WAVE

" ─── Text Video Commands ─────────────────────────────────────────────────────
syntax keyword vbVideoKeyword
  \ BANK BLANK CATCH CHARPAT CHARSET COLORS COPYSET EXTENDED
  \ LOWERCASE MULTI NORMAL PANX PANY UPPERCASE VIDLOC

" ─── Core BASIC Keywords ─────────────────────────────────────────────────────
syntax keyword vbKeyword
  \ ASC BUTTON BYTES CHR$ CLOCK CLOSE CLS CMD COPY DATA DEBUG
  \ DEF DETEXT DO DUP$ ELSE END FETCH FILL FOR GET GOSUB GOTO
  \ HALT IF INPUT JOIN JOY KEYPRESS LEFT$ LEN LOC LONGPEEK
  \ LONGPOKE MID$ MODULE NEXT ON OPEN PADBUT PADDLE PAUSE
  \ PEEK POKE POLL PRINT READ REM RESTORE RESUME RETURN
  \ REUPEEK REUPOKE RIGHT$ SPC SPLIT STASH STATUS STOP STR$
  \ STRINGS SWAP SWITCH SYS TAB THEN TRAP VAL VERSION WAIT
  \ POINT PROC PASS SEND LABEL START

" ─── Special Constants / Operators ───────────────────────────────────────────
syntax keyword vbSpecial TO STEP AND OR EOR
syntax match vbPi /\bπ\b/

" ─── ML-safe Commands (usable inside assembler blocks) ───────────────────────
syntax keyword vbMLSafe
  \ START GOTO GOSUB RETURN REM TAG PROC MODULE LOCAL GLOBAL
  \ ADD SUBTRACT COMPARE HALF DOUBLE VARIABLES HALT RESUME
  \ VERSION DEBUG STARTINT RASTER BYTES STRINGS

" ─── Highlight Links ─────────────────────────────────────────────────────────
highlight default link vbLineNumber   Number
highlight default link vbComment      Comment
highlight default link vbMLComment    Comment
highlight default link vbTodo         Todo
highlight default link vbString       String
highlight default link vbStringVar    Identifier
highlight default link vbHexNumber    Number
highlight default link vbNumber       Number
highlight default link vbAsmBlock     PreProc
highlight default link vbAsmMnemonic  Function
highlight default link vbAsmSwitch    PreProc
highlight default link vbEditKeyword  Keyword
highlight default link vbDiskKeyword  Keyword
highlight default link vbVarKeyword   Type
highlight default link vbMathKeyword  Function
highlight default link vbBitmapKeyword Special
highlight default link vbSpriteKeyword Special
highlight default link vbInterruptKeyword Special
highlight default link vbSoundKeyword Special
highlight default link vbVideoKeyword Special
highlight default link vbKeyword      Statement
highlight default link vbMLSafe       Statement
highlight default link vbSpecial      Operator
highlight default link vbPi           Constant

let b:current_syntax = 'visionbasic'
