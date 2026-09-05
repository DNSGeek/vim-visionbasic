" Vim filetype plugin
" Language: Vision BASIC (compiled BASIC for the Commodore 64)
" URL:      https://www.visionbasic.net
scriptencoding utf-8

if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

" ─── Buffer options ──────────────────────────────────────────────────────────
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal textwidth=0
setlocal nowrap
setlocal comments=:REM,:;
setlocal commentstring=REM\ %s
setlocal omnifunc=visionbasic#complete
setlocal suffixesadd=.bas,.vb64,.vbas

let b:undo_ftplugin = 'setlocal expandtab< tabstop< shiftwidth< softtabstop<'
  \ . ' textwidth< wrap< comments< commentstring< omnifunc< suffixesadd<'
  \ . ' iskeyword< | silent! nunmap <buffer> K'
  \ . ' | silent! nunmap <buffer> <LocalLeader>c'
  \ . ' | silent! nunmap <buffer> <LocalLeader>u'
  \ . ' | silent! autocmd! visionbasic_uppercase * <buffer>'

" ─── BASIC / ML comment mode ─────────────────────────────────────────────────
" Vision BASIC has two comment styles: REM in BASIC mode and ; in machine
" language mode. 'commentstring' can only hold one, so it is toggled.
if !exists('b:visionbasic_ml_mode')
  let b:visionbasic_ml_mode = 0
endif

function! s:ToggleCommentMode() abort
  let b:visionbasic_ml_mode = !b:visionbasic_ml_mode
  if b:visionbasic_ml_mode
    setlocal commentstring=;\ %s
    echo 'Vision BASIC: ML comment mode (;)'
  else
    setlocal commentstring=REM\ %s
    echo 'Vision BASIC: BASIC comment mode (REM)'
  endif
endfunction

command! -buffer VBCommentMode call s:ToggleCommentMode()

" ─── Documentation lookup ────────────────────────────────────────────────────
command! -buffer -nargs=? -complete=custom,s:CompleteKeyword VBDoc
  \ call visionbasic#doc(<q-args>)

function! s:CompleteKeyword(arglead, cmdline, cursorpos) abort
  return join(visionbasic#keywords() + visionbasic#mnemonics(), "\n")
endfunction

" ─── Line numbering ──────────────────────────────────────────────────────────
" :VBNumber [start] [step]   add line numbers to unnumbered lines in a range
" :VBRenumber [start] [step] renumber, following GOTO/GOSUB/THEN targets
command! -buffer -range=% -nargs=* VBNumber
  \ call s:Number(<line1>, <line2>, <f-args>)
command! -buffer -nargs=* VBRenumber call s:Renumber(<f-args>)

function! s:Number(first, last, ...) abort
  let l:next = a:0 >= 1 ? str2nr(a:1) : 10
  let l:step = a:0 >= 2 ? str2nr(a:2) : 10
  for l:lnum in range(a:first, a:last)
    let l:line = getline(l:lnum)
    if l:line =~# '^\s*$' || l:line =~# '^\s*\d'
      continue
    endif
    call setline(l:lnum, l:next . ' ' . substitute(l:line, '^\s*', '', ''))
    let l:next += l:step
  endfor
endfunction

" Which arguments of a keyword are line numbers:
"   'all'  every number in the comma-separated list  (ON A GOTO 10,20,30)
"   1      only the first                            (TRAP 9000, ERRADDR)
"   2      only the second                           (INTERRUPT 100, 1000)
" POINT is handled separately: its line number follows an "=".
let s:refs = [
  \ ['\c\<\%(GOTO\|GOSUB\|THEN\|ELSE\)\>', 'all'],
  \ ['\c\<\%(DESC\|TRAP\|DO\)\>', 1],
  \ ['\c\<INTERRUPT\>', 2],
  \ ]
let s:arglist = '\%(\s*\d\+\s*\%(,\s*\d\+\s*\)*\)'
let s:point = '\c\<POINT\>\%(\s\+TAG\)\=\s\+\w\+\s*=\s*\zs\d\+'

function! s:MapNumber(old) abort
  return get(s:renumber_map, a:old, a:old)
endfunction

" Rewrite the selected entries of a comma-separated argument list.
function! s:MapArgs(text, which) abort
  let l:parts = split(a:text, ',', 1)
  let l:idx = 0
  for l:k in range(len(l:parts))
    if l:parts[l:k] !~# '^\s*\d\+\s*$'
      continue
    endif
    let l:idx += 1
    if a:which is# 'all' || a:which == l:idx
      let l:parts[l:k] = substitute(l:parts[l:k], '\d\+',
        \ '\=s:MapNumber(submatch(0))', '')
    endif
  endfor
  return join(l:parts, ',')
endfunction

function! s:Renumber(...) abort
  let l:next = a:0 >= 1 ? str2nr(a:1) : 10
  let l:step = a:0 >= 2 ? str2nr(a:2) : 10

  let l:map = {}
  for l:lnum in range(1, line('$'))
    let l:old = matchstr(getline(l:lnum), '^\s*\zs\d\+')
    if l:old !=# ''
      let l:map[l:old] = l:next
      let l:next += l:step
    endif
  endfor
  if empty(l:map)
    echohl WarningMsg | echomsg 'Vision BASIC: no numbered lines' | echohl None
    return
  endif

  let s:renumber_map = l:map
  try
    for l:lnum in range(1, line('$'))
      let l:line = getline(l:lnum)

      " Leave anything from a REM or ML comment onwards untouched.
      let l:cut = match(l:line, '\c\<REM\>\|;')
      let l:code = l:cut < 0 ? l:line : strpart(l:line, 0, l:cut)
      let l:tail = l:cut < 0 ? '' : strpart(l:line, l:cut)

      let l:new = substitute(l:code, '^\(\s*\)\(\d\+\)',
        \ '\=submatch(1) . s:MapNumber(submatch(2))', '')
      for [l:pattern, l:which] in s:refs
        let l:new = substitute(l:new, l:pattern . '\zs' . s:arglist,
          \ '\=s:MapArgs(submatch(0), l:which)', 'g')
      endfor
      let l:new = substitute(l:new, s:point, '\=s:MapNumber(submatch(0))', 'g')

      if l:new . l:tail !=# l:line
        call setline(l:lnum, l:new . l:tail)
      endif
    endfor
  finally
    unlet! s:renumber_map
  endtry
endfunction

" ─── Keyword auto-uppercase ──────────────────────────────────────────────────
" Vision BASIC listings are upper case. Type in lower case; on leaving insert
" mode the keywords on the line are folded up, leaving strings, comments and
" your own variable names alone.
" Set g:visionbasic_auto_uppercase = 0 to turn this off.
if get(g:, 'visionbasic_auto_uppercase', 1)
  augroup visionbasic_uppercase
    autocmd! * <buffer>
    autocmd InsertLeave <buffer> call visionbasic#uppercase_line(line('.'))
  augroup END
endif

command! -buffer -range=% VBUppercase
  \ call s:UppercaseRange(<line1>, <line2>)

function! s:UppercaseRange(first, last) abort
  for l:lnum in range(a:first, a:last)
    call visionbasic#uppercase_line(l:lnum)
  endfor
endfunction

" ─── Mappings ────────────────────────────────────────────────────────────────
if !hasmapto('<Plug>VisionBasicDoc') && maparg('K', 'n') ==# ''
  nnoremap <buffer> <silent> K :call visionbasic#doc()<CR>
endif
if !hasmapto('<Plug>VisionBasicCommentMode')
  nnoremap <buffer> <silent> <LocalLeader>c :VBCommentMode<CR>
endif
if !hasmapto('<Plug>VisionBasicUppercase')
  nnoremap <buffer> <silent> <LocalLeader>u :VBUppercase<CR>
endif

" ─── matchit ─────────────────────────────────────────────────────────────────
if exists('loaded_matchit') && !exists('b:match_words')
  let b:match_ignorecase = 1
  let b:match_words = '\<FOR\>:\<NEXT\>,'
    \ . '\<PROC\>:\<RETURN\>,'
    \ . '\<STARTINT\>:\<INTEND\>,'
    \ . '\<LOCAL\>:\<GLOBAL\>,'
    \ . '\<ASSEM\>:\<BASIC\>,'
    \ . '\<MODULE\>:\<MODULE\s\+END\>'
  let b:undo_ftplugin .= ' | unlet! b:match_words b:match_ignorecase'
endif

let &cpoptions = s:save_cpo
unlet s:save_cpo
