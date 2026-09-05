" Vim indent file
" Language: Vision BASIC (compiled BASIC for the Commodore 64)
"
" Line-numbered listings are left flush against the left margin, the way LIST
" prints them. Unnumbered source — the style you write first and number later
" with :VBNumber — is indented by block structure.
scriptencoding utf-8

if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetVisionBasicIndent()
setlocal indentkeys=o,O,0=NEXT,0=RETURN,0=INTEND,0=GLOBAL,0=MODULE,0=BASIC

let b:undo_indent = 'setlocal indentexpr< indentkeys<'

if exists('*GetVisionBasicIndent')
  finish
endif

let s:open = '\c\<\%(FOR\|PROC\|STARTINT\|LOCAL\|ASSEM\)\>\|\c\<MODULE\>\%(\s\+END\>\)\@!'
let s:close = '\c\<\%(NEXT\|RETURN\|INTEND\|GLOBAL\|BASIC\)\>\|\c\<MODULE\s\+END\>'

" Everything after the line number, with strings and comments blanked out.
function! s:Code(lnum) abort
  let l:line = substitute(getline(a:lnum), '^\s*\d\+\s\=', '', '')
  let l:line = substitute(l:line, '"[^"]*"\=', '', 'g')
  let l:line = substitute(l:line, '\c\<REM\>.*$', '', '')
  return substitute(l:line, ';.*$', '', '')
endfunction

function! s:Count(text, pattern) abort
  let l:n = 0
  let l:start = 0
  while 1
    let l:idx = match(a:text, a:pattern, l:start)
    if l:idx < 0
      break
    endif
    let l:n += 1
    let l:start = matchend(a:text, a:pattern, l:start)
  endwhile
  return l:n
endfunction

function! GetVisionBasicIndent() abort
  " A numbered listing is printed flush left; keep it that way.
  if getline(v:lnum) =~# '^\s*\d'
    return 0
  endif

  let l:lnum = prevnonblank(v:lnum - 1)
  if l:lnum == 0
    return 0
  endif

  let l:prev = s:Code(l:lnum)
  let l:ind = indent(l:lnum)
  let l:ind += shiftwidth() * s:Count(l:prev, s:open)
  let l:ind -= shiftwidth() * s:Count(l:prev, s:close)
  let l:ind -= shiftwidth() * s:Count(s:Code(v:lnum), s:close)

  return l:ind < 0 ? 0 : l:ind
endfunction
