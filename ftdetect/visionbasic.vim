" Vision BASIC filetype detection.
"
" .bas is contested — Visual Basic, QBasic, FreeBASIC, CBM BASIC, MMBasic and
" half a dozen other dialects use it, and both Vim and Neovim ship their own
" guess for it. So a .bas file is only claimed when its contents actually look
" like Vision BASIC; the dedicated extensions are claimed outright.
"
"   let g:visionbasic_claim_bas = 1   " always claim *.bas
"   let g:visionbasic_claim_bas = 0   " never sniff, leave *.bas alone

scriptencoding utf-8

if exists('g:loaded_visionbasic_ftdetect')
  finish
endif
let g:loaded_visionbasic_ftdetect = 1

" Keywords that exist in Vision BASIC and in essentially no other BASIC.
let s:markers = join([
  \ 'ASSEM', 'ALLMOBS', 'BMPCLR', 'BMPCOL', 'BMPLOC', 'CHARPAT', 'COPYSET',
  \ 'DETEXT', 'DUP\$', 'GSAVE', 'HALTINT', 'INTEND', 'KEYPRESS', 'LISTER',
  \ 'LLIST', 'LONGPEEK', 'LONGPOKE', 'MOBCLR', 'MOBCOL', 'MOBEXP', 'MOBPAT',
  \ 'MOBSET', 'MOBXY', 'PADBUT', 'PANX', 'PANY', 'PLIST', 'REUPEEK', 'REUPOKE',
  \ 'SIDCLR', 'STARTINT', 'VIDLOC', 'VLIST', 'WHOLE',
  \ ], '\|')
let s:pattern = '\c\<\%(' . s:markers . '\)\>\|\c\<DESC\s\+\d\+\s*,'

" Generic guesses a positive Vision BASIC sniff is allowed to win against.
" Anything else was chosen deliberately — by the user or a modeline — and is
" left alone.
let s:generic = ['', 'basic', 'vb', 'vbasic', 'cbmbasic', 'freebasic', 'qb64', 'mmbasic']

function! s:Sniff() abort
  for l:lnum in range(1, min([line('$'), 100]))
    if getline(l:lnum) =~# s:pattern
      return 1
    endif
  endfor
  return 0
endfunction

function! s:DetectVisionBasic() abort
  if index(s:generic, &filetype) < 0
    return
  endif
  let l:claim = get(g:, 'visionbasic_claim_bas', -1)
  if l:claim == 0
    return
  endif
  if l:claim == 1 || s:Sniff()
    let &l:filetype = 'visionbasic'
  endif
endfunction

" These belong in "filetypedetect", the group Vim sources ftdetect/*.vim into
" and replays over already-loaded buffers when :filetype on runs. Naming it
" explicitly (without :autocmd!, which would wipe everyone else's rules) is
" equivalent to leaving them ungrouped, and keeps linters happy.
"
" "nested" is required throughout: Vim's own *.bas rule may already have set a
" filetype by the time these run, and without nesting, changing 'filetype'
" again would not fire FileType — leaving the ftplugin, indent and syntax
" files unloaded.
augroup filetypedetect
  autocmd BufRead,BufNewFile *.vb64,*.vbas nested setfiletype visionbasic
  autocmd BufRead,BufNewFile *.bas nested call s:DetectVisionBasic()

  " Both Vim and Neovim register a *.bas rule of their own, and whether it runs
  " before or after this one depends on 'runtimepath' order — so if theirs won,
  " take a second look once every BufRead handler has had its say. BufWinEnter
  " is the right hook for that: reacting to FileType instead would leave the
  " ftplugin loader running with the *old* filetype in <amatch>, unloading this
  " plugin the moment it had been loaded.
  autocmd BufWinEnter *.bas nested call s:DetectVisionBasic()
augroup END
