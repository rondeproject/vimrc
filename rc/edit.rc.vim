"---------------------------------------------------------------------------
" Edit:
"

" Change path to slash
set shellslash

" Smart insert tab setting.
set smarttab
" Auto indent tab setting.
set autoindent smartindent
" Exchange tab to spaces.
"set expandtab
" Substitute <Tab> with blanks.
set tabstop=4
" Spaces instead <Tab>.
set softtabstop=0
" Autoindent width.
set shiftwidth=4
" Round indent by shiftwidth.
"set shiftround

" Enable modeline.
set modeline

" Use clipboard register.
if has('unnamedplus')
  set clipboard& clipboard+=unnamedplus
else
  set clipboard& clipboard+=unnamed
endif

" Enable backspace delete indent and newline.
set backspace=indent,eol,start

" Highlight parenthesis.
set showmatch
" Highlight when CursorMoved.
"set cpoptions-=m
"set matchtime=1
" Highlight <>.
set matchpairs+=<:>

" Display another buffer when current buffer isn't saved.
"set hidden

" Auto reload if file is changed.
set autoread

" Ignore case on insert completion.
set infercase

" Search home directory path on cd.
" But can't complete.
" set cdpath+=~

" Enable folding.
set foldenable
" set foldmethod=expr
set foldmethod=marker
" Show folding level.
set foldcolumn=1
set fillchars=vert:\|
set commentstring=%s

if exists('*FoldCCtext')
  " Use FoldCCtext().
  set foldtext=FoldCCtext()
endif

" Use vimgrep.
"set grepprg=internal
" Use grep.
set grepprg=grep\ -inH

" Exclude = from isfilename.
set isfname-==

" Reload .vimrc automatically.
autocmd MyAutoCmd BufWritePost .vimrc,vimrc,*.rc.vim,neobundle.toml
      \ NeoBundleClearCache | source $MYVIMRC | redraw

" Keymapping timeout.
set timeout timeoutlen=3000 ttimeoutlen=100

" CursorHold time.
set updatetime=1000

" Set swap directory.
set directory-=.

" Set viminfo
set viminfo='100,<50,s10,h,!

" diff option
set diffopt+=vertical

if v:version >= 703
  " Set undofile.
  set undofile
  let &undodir=&directory
endif

if v:version < 703 || (v:version == 7.3 && !has('patch336'))
  " Vim's bug.
  set notagbsearch
endif

" Enable virtualedit in visual block mode.
set virtualedit=block

" Set keyword help.
set keywordprg=:help

" Check timestamp more for 'autoread'.
autocmd MyAutoCmd WinEnter * checktime

" Disable paste.
autocmd MyAutoCmd InsertLeave *
      \ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

" Update diff.
autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

" Make directory automatically.
" --------------------------------------
" http://vim-users.jp/2011/02/hack202/

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force)
  if !isdirectory(a:dir) && &l:buftype == '' &&
        \ (a:force || input(printf('"%s" does not exist. Create? [y/N]',
        \              a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

" Use autofmt.
set formatexpr=autofmt#japanese#formatexpr()

" Use blowfish2
" https://dgl.cx/2014/10/vim-blowfish
if has('cryptv')
  " It seems 15ms overhead.
  " set cryptmethod=blowfish2
endif

