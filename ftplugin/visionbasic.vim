" Vim filetype plugin
" Language:    Vision BASIC (C64 enhanced BASIC)
" Maintainer:  Tom
" Last Change: 2026
scriptencoding utf-8

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

" ─── Basic Settings ───────────────────────────────────────────────────────────
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal textwidth=0
setlocal nowrap

" ─── Comment String ───────────────────────────────────────────────────────────
" Default to REM for BASIC mode
" Use vb_ml_mode to toggle to ; for assembler mode
setlocal commentstring=REM\ %s

" ─── Comment Toggle ───────────────────────────────────────────────────────────
" Track current mode: 0 = BASIC (REM), 1 = ML (;)
if !exists('b:vb_ml_mode')
  let b:vb_ml_mode = 0
endif

function! s:ToggleVBCommentMode()
  if b:vb_ml_mode == 0
    let b:vb_ml_mode = 1
    setlocal commentstring=;\ %s
    echo 'Vision BASIC: ML comment mode (;)'
  else
    let b:vb_ml_mode = 0
    setlocal commentstring=REM\ %s
    echo 'Vision BASIC: BASIC comment mode (REM)'
  endif
endfunction

" Map <LocalLeader>c to toggle comment mode
nnoremap <buffer> <LocalLeader>c :call <SID>ToggleVBCommentMode()<CR>
" Also auto-switch when cursor line contains ASSEM or BASIC keyword
" (advisory echo only — doesn't force commentstring)
function! s:CheckAsmMode()
  let l:line = getline('.')
  if l:line =~? '\<ASSEM\>'
    echo 'Tip: Switch to ML comment mode with <LocalLeader>c'
  elseif l:line =~? '\<BASIC\>'
    echo 'Tip: Switch to BASIC comment mode with <LocalLeader>c'
  endif
endfunction
augroup visionbasic_asmhint
  autocmd! CursorMoved <buffer> call s:CheckAsmMode()
augroup END

" ─── Auto-Uppercase Keywords ──────────────────────────────────────────────────
" After leaving insert mode, uppercase all Vision BASIC keywords on the
" current line. Uses a post-InsertLeave autocmd so it doesn't interrupt typing.

let s:vb_keywords = [
  \ 'ADSR', 'ABS', 'ADD', 'ALLMOBS', 'AND', 'ASC', 'ASSEM',
  \ 'BANK', 'BASIC', 'BITMAP', 'BLANK', 'BMPCLR', 'BMPCOL', 'BMPLOC',
  \ 'BUTTON', 'BYTES',
  \ 'CATCH', 'CHARPAT', 'CHARSET', 'CHR\$', 'CLR', 'CLS', 'CLOCK',
  \ 'CLOSE', 'CMD', 'CODE', 'COLLISION', 'COLORS', 'COMP', 'COMPARE',
  \ 'COMP', 'COPY', 'COPYSET', 'CUTOFF',
  \ 'DATA', 'DEBUG', 'DEC', 'DECIMAL', 'DEF', 'DELETE', 'DESC',
  \ 'DETECT', 'DEVICE', 'DETEXT', 'DIM', 'DIR', 'DISK', 'DO',
  \ 'DOUBLE', 'DUP\$',
  \ 'ELSE', 'END', 'EOR', 'ERROR', 'EXEC', 'EXTENDED',
  \ 'FAST', 'FETCH', 'FILL', 'FILTER', 'FIND', 'FOR', 'FRAC', 'FREQ',
  \ 'GET', 'GLOBAL', 'GOSUB', 'GOTO', 'GSAVE',
  \ 'HALF', 'HALT', 'HALTINT', 'HLINE',
  \ 'IF', 'INC', 'INPUT', 'INT', 'INTEND', 'INTERRUPT',
  \ 'JOIN', 'JOY',
  \ 'KEYPRESS',
  \ 'LABEL', 'LEFT\$', 'LEN', 'LET', 'LIMITS', 'LINE', 'LIST',
  \ 'LISTER', 'LITE', 'LLIST', 'LOAD', 'LOC', 'LOCAL', 'LONGPEEK',
  \ 'LONGPOKE', 'LOWERCASE',
  \ 'MID\$', 'MOB', 'MOBCLR', 'MOBCOL', 'MOBEXP', 'MOBPAT', 'MOBSET',
  \ 'MOBXY', 'MODULE', 'MULTI',
  \ 'NEW', 'NEXT', 'NORMAL',
  \ 'OLD', 'ON', 'OPEN', 'OR',
  \ 'PADBUT', 'PADDLE', 'PANX', 'PANY', 'PASS', 'PAUSE', 'PEEK',
  \ 'PLIST', 'PLOT', 'POINT', 'POKE', 'POLL', 'PRINT', 'PROC', 'PULSE',
  \ 'QUIT',
  \ 'RANDOM', 'RASTER', 'READ', 'REM', 'RENUM', 'RESTORE', 'RESUME',
  \ 'RETURN', 'REUPEEK', 'REUPOKE', 'RIGHT\$', 'RND', 'RUN',
  \ 'SAVE', 'SEND', 'SGN', 'SHAPE', 'SIDCLR', 'SLOW', 'SPC', 'SPLIT',
  \ 'STASH', 'START', 'STARTINT', 'STATUS', 'STEP', 'STOP', 'STR\$',
  \ 'STRINGS', 'SUBTRACT', 'SWAP', 'SWITCH', 'SYS',
  \ 'TAB', 'TAG', 'THEN', 'TO', 'TRAP',
  \ 'UPPERCASE',
  \ 'VAL', 'VARIABLES', 'VERIFY', 'VERSION', 'VIDLOC', 'VLINE', 'VLIST',
  \ 'VOICE', 'VOL',
  \ 'WAIT', 'WAVE', 'WHOLE',
  \ ]

function! s:UppercaseKeywords()
  " Save cursor position
  let l:save_pos = getpos('.')
  let l:lnum = line('.')
  let l:line = getline(l:lnum)

  " Don't touch content inside strings or comments
  " Simple approach: uppercase known keywords only
  for kw in s:vb_keywords
    " Match keyword case-insensitively, replace with uppercase
    " Only match whole words (not inside other words)
    let l:pattern = '\c\<' . kw . '\>'
    let l:line = substitute(l:line, l:pattern, kw, 'g')
  endfor

  call setline(l:lnum, l:line)
  call setpos('.', l:save_pos)
endfunction

augroup visionbasic_uppercase
  autocmd! InsertLeave <buffer> call s:UppercaseKeywords()
augroup END

" ─── Cleanup ──────────────────────────────────────────────────────────────────
let &cpo = s:save_cpo
unlet s:save_cpo
