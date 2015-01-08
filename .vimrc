" vim-tiny or vim-small は読み込まない
if !1 | finish | endif

let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_sudo = $SUDO_USER != '' && $USER !=# $SUDO_USER
			\ && $HOME !=# expand('~'.$USER)
			\ && $HOME ==# expand('~'.$SUDO_USER)

function! IsWindows()
	return s:is_windows
endfunction

function! IsMac()
	return !s:is_windows && !s:is_cygwin
				\ && (has('mac') || has('macunix') || has('gui_macvim') ||
				\ (!executable('xdg-open') &&
				\ system('uname') =~? '^darwin'))
endfunction

function! s:SID_PREFIX()
	return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

function! s:strwidthpart(str, width)
	if a:width <= 0
		return ''
	endif
	let ret = a:str
	let width = s:wcswidth(a:str)
	while width > a:width
		let char = matchstr(ret, '.$')
		let ret = ret[: -1 - len(char)]
		let width -= s:wcswidth(char)
	endwhile
	return ret
endfunction

function! s:wcswidth(str)
	if a:str =~# '^[\x00-\x7f]*$'
		return strlen(a:str)
	end
	let mx_first = '^\(.\)'
	let str = a:str
	let width = 0
	while 1
		let ucs = char2nr(substitute(str, mx_first, '\1', ''))
		if ucs == 0
			break
		endif
		let width += s:_wcwidth(ucs)
		let str = substitute(str, mx_first, '', '')
	endwhile
	return width
endfunction

"-------------------------------------------------------
" NeoBundle設定
"-------------------------------------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
" NERDTree
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/nerdcommenter'

" Grep
NeoBundle 'grep.vim'
NeoBundle 'rking/ag.vim'

" vimproc
NeoBundle 'Shougo/vimproc',
			\ { 'build' : {
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'linux' : 'make -f make_unix.mak',
			\ },
			\}

" vim--submode
NeoBundle 'kana/vim-submode'

" QuickRun
NeoBundle 'thinca/vim-quickrun'

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" FuzzyFinder
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'QuickBuf'

" YankRing
"NeoBundle 'YankRing.vim'

" Capture
NeoBundle 'tyru/capture.vim'

" Gundo
NeoBundle 'sjl/gundo.vim'

" VimCalc
NeoBundle 'gregsexton/VimCalc'

" Tag
NeoBundle "tsukkee/unite-tag"

" SVN
NeoBundle "kmnk/vim-unite-svn"

" GIT
NeoBundle 'kmnk/vim-unite-giti.git'

" ColorScheme
NeoBundle "w0ng/vim-hybrid"
NeoBundle "nanotech/jellybeans.vim"

call neobundle#end()
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
NeoBundleCheck
 
" ==================== 基本の設定 ==================== "
" 全般設定
let mapleader=" "           " leaderをスペースに変更
set viminfo='100,<50,s10,h,! " YankRing用に!を追加
set shellslash              " Windowsでディレクトリパスの区切り文字に / を使えるようにする
set lazyredraw              " マクロなどを実行中は描画を中断
"set mouse=a                 " マウス操作
set cursorline              " カーソルライン
set t_Co=256                " 256色


" タブ周り
" tabstopはTab文字を画面上で何文字分に展開するか
" shiftwidthはcindentやautoindent時に挿入されるインデントの幅
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
"set expandtab              " タブを空白文字に展開
set autoindent smartindent " 自動インデント，スマートインデント

" 入力補助
set backspace=indent,eol,start " バックスペースでなんでも消せるように
set formatoptions+=m           " 整形オプション，マルチバイト系を追加
set clipboard^=unnamed         " クリップボードにコピー

" コマンド補完
set wildmenu           " コマンド補完を強化
set wildmode=list:full " リスト表示，最長マッチ

" 検索関連
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト

" ファイル関連
set nobackup   " バックアップ取らない
set autoread   " 他で書き換えられたら自動で読み直す
set noswapfile " スワップファイル作らない
"set hidden     " 編集中でも他のファイルを開けるようにする

" ヘルプファイル
if IsWindows()
    helptags ~/vimfiles/doc/
else
    helptags ~/.vim/doc/
endif

"表示関連
set showmatch         " 括弧の対応をハイライト
set showcmd           " 入力中のコマンドを表示
set number            " 行番号表示
set nowrap            " 画面幅で折り返す
set list              " 不可視文字表示
set listchars=tab:>\ ,trail:-,extends:»,precedes:«,nbsp:% " 不可視文字の表示方法
set scrolloff=5       " 行送り
if s:is_cygwin            " Cygwin環境だとタイトルが変になる
	set notitle           " タイトル書き換えない
else
	set title             " タイトル変更
	set titlelen=95       " タイトルの長さ
	let &titlestring="
				\ %{expand('%:p:~:.')}%(%m%r%w%)
				\ %<\(%{".s:SID_PREFIX()."strwidthpart(
				\ fnamemodify(&filetype ==# 'vimfiler' ?
				\ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
				\ &columns-len(expand('%:p:.:~')))}\) - VIM"
endif

function! s:getEncodeFormat(enc)
	" if a:enc ==# 'utf-8'
		" return "UTF-8"
	" endif
	" if a:enc ==# 'cp20932'
		" return "EUC"
	" endif
	" if a:enc ==# 'euc-jp' || a:enc ==# 'euc-jisx0213'
		" return "EUC-JP"
	" endif
	" if a:enc ==# 'cp932'
		" return "SJIS"
	" endif
	" if a:enc =~# 'iso-2022-jp*'
		" return "JIS"
	" endif

	return a:enc
endfunction

" ステータスライン関連
set laststatus=2
"set statusline=%<%F %r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%4v(ASCII=%03.3b,HEX=%02.2B) %l/%L(%P)%m
"set statusline=%F%m%r%h%w\%=[TYPE=%Y]\[ENC=%{&fileencoding}]\[FORMAT=%{&ff}]\[POS=%04v]\[LOW=%4l/%4L\ (%3p%%)]
let &statusline="%{'['.winnr().'/'.winnr('$').(winnr('#')==winnr()?'#':'').']'}\ "
			\ . "%f %m%r%h%w"
			\ . "\%="
			\ . "["."%{(&filetype!='' ? &filetype.', ' : '')}".s:getEncodeFormat(&fenc!='' ? &fenc : &enc).", "."%{&ff}".']'
			\ . "[line %4l/%4L col %3c] (%3p%%)"

" エンコーディング関連
set ffs=unix,dos,mac " 改行文字
"set ffs=unix " 改行文字

" 文字コードの自動認識
" 適当な文字コード判別
set encoding=utf-8
if !has('gui_running')
	if &term ==# 'win32' &&
				\ (v:version < 703 || (v:version == 703 && has('patch814')))
		" Setting when use the non-GUI Japanese console.

		" Garbled unless set this.
		set termencoding=cp932
		" Japanese input changes itself unless set this. Be careful because the
		" automatic recognition of the character code is not possible!
		set encoding=japan
	else
		if $ENV_ACCESS ==# 'linux'
			set termencoding=euc-jp
		elseif $ENV_ACCESS ==# 'colinux'
			set termencoding=utf-8
		else " fallback
			set termencoding= " same as 'encoding'
		endif
	endif
elseif IsWindows()
	" For system.
	set termencoding=cp932
endif

" 厳密な文字コード判別
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
if !exists('did_encoding_settings') && has('iconv')
	let s:enc_euc = 'euc-jp'
	let s:enc_jis = 'iso-2022-jp'

	" Does iconv support JIS X 0213?
	if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
		let s:enc_euc = 'euc-jisx0213,euc-jp'
		let s:enc_jis = 'iso-2022-jp-3'
	endif

	" Build encodings.
	let &fileencodings = 'ucs-bom'
	if &encoding !=# 'utf-8'
		let &fileencodings .= ',' . 'ucs-2le'
		let &fileencodings .= ',' . 'ucs-2'
	endif
	let &fileencodings .= ',' . s:enc_jis
	let &fileencodings .= ',' . 'utf-8'

	if &encoding ==# 'utf-8'
		let &fileencodings .= ',' . s:enc_euc
		let &fileencodings .= ',' . 'cp932'
	elseif &encoding =~# '^euc-\%(jp\|jisx0213\)$'
		let &encoding = s:enc_euc
		let &fileencodings .= ',' . 'cp932'
		let &fileencodings .= ',' . &encoding
	else " cp932
		let &fileencodings .= ',' . s:enc_euc
		let &fileencodings .= ',' . &encoding
	endif
	let &fileencodings .= ',' . 'cp20932'

	unlet s:enc_euc
	unlet s:enc_jis

	let did_encoding_settings = 1
endif

" UTF-8の□や○でカーソル位置がずれないようにする
" Terminal.appはどっちにしてもダメ，PrivatePortsのiTermでやる
set ambiwidth=double

" ファイルタイプ関連
" 使用できる色は
" :edit $VIMRUNTIME/syntax/colortest.vim
" :source %
" で、設定名と現在の色は
" :highlight

syntax on             " シンタックスカラーリングオン
colorscheme default   " 背景白用カラースキーム
highlight ShowMarksHLl ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight ShowMarksHLu ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight ShowMarksHLo ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight ShowMarksHLm ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定

" diff option
set diffopt+=vertical

set complete+=k    " 補完に辞書ファイル追加
filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on " ファイルタイプごとのプラグインを使う

" Omni補完関連
" $VIMRUNTIME/autoload/htmlcomplete.vimの645行目をコメントアウントしておくとhtmlの補完が小文字になる

set completeopt=menu,preview,menuone " 補完表示設定

" TabでOmni補完及びポップアップメニューの選択
"function InsertTabWrapper(is_shift)
"    if pumvisible()
"        return a:is_shift ? "<C-p>" : "<C-n>"
"    endif
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ 'k|<|/' " htmlで補完できるように<,/でもOmni補完
"        return "<tab>"
"    elseif exists('&omnifunc') && &omnifunc == ''
"        return a:is_shift ? "<C-p>" : "<C-n>"
"    else
"        return "<C-x><C-o>"
"    endif
"endfunction
"inoremap <tab> <C-r>=InsertTabWrapper(0)<CR>
" Shift-Tabはうまくいかないようだ
" inoremap <S-tab> <C-r>=InsertTabWrapper(1)<CR>

" CRでOmni確定&改行
"function InsertCrWrapper()
"    return pumvisible() ? "<C-y><CR>" : "<CR>"
"endfunction
"inoremap <CR> <C-r>=InsertCrWrapper()<CR>

" ポップアップメニューの色変える
highlight Pmenu ctermbg=lightgray ctermfg=black
highlight PmenuSel ctermbg=lightblue ctermfg=black
highlight PmenuSbar ctermbg=darkgray
highlight PmenuThumb ctermbg=lightgray

" vimdiff の設定
highlight DiffAdd    ctermfg=black ctermbg=2
highlight DiffChange ctermfg=black ctermbg=3
highlight DiffDelete ctermfg=black ctermbg=6
highlight DiffText   ctermfg=black ctermbg=7

" ==================== キーマップ ==================== "
" 表示行単位で移動
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk

" ハイライト消す
nmap <silent> <ESC><ESC> :nohlsearch<CR>

" コピペ
" Macの場合は普通にComamnd-C，Command-Vも使えたりする
if has('mac')
    map <silent> gy :call YankPB()<CR>
    function! YankPB()
        let tmp = tempname()
        call writefile(getline(a:firstline, a:lastline), tmp, 'b')
        silent exec ":!cat " . tmp . " | iconv -f utf-8 -t shift-jis | pbcopy"
    endfunction
endif
if has('win32')
    noremap gy "+y
    " ペーストがうまく動いてない
    noremap gp "+p
endif

" マウス操作を有効にする
" iTermのみ，Terminal.appでは無効
if has('mac')
    set mouse=a
    set ttymouse=xterm2
endif

" ==================== プラグインの設定 ==================== "

" NERD_comments
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
let NERDShutUp = 1
nmap <unique> <silent> <Space>/ <Plug>NERDCommenterToggle
vmap <unique> <silent> <Space>/ <Plug>NERDCommenterToggle

" NERD_tree
let NERDTreeShowHidden = 1
nmap <unique> <silent> <C-e> :NERDTreeToggle<CR>
"autocmd VimEnter * execute 'NERDTree'

" Unite
nnoremap [unite]  <Nop>
nmap     <Space>  [unite]
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1
" command
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite file<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [unite]F :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]w :<C-u>Unite window<CR>
nnoremap <silent> [unite]h :<C-u>Unite history/yank<CR>
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
autocmd FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')

" grep
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif

" QuickRun
let quickrun_no_default_key_mappings=1
silent! map <unique> <F7> <Plug>(quickrun)

" YankRing
"nnoremap <silent> ,y :YRShow<CR>

" Gundo
nnoremap <silent> <F3> :GundoToggle<CR>

" Tab
function! s:my_tabline()  "{{{
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
		let no = i  " display 0-origin tabpagenr.
		let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
		let title = fnamemodify(bufname(bufnr), ':t')
		let title = '[' . title . ']'
		let s .= '%'.i.'T'
		let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
		let s .= no . ':' . title
		let s .= mod
		let s .= '%#TabLineFill# '
	endfor
	let s .= '%#TabLineFill#%T%=%#TabLine#'
	return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap        t       [Tag]
" Tab jump
for n in range(1, 9)
	execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]w :tabclose<CR>
map <silent> [Tag]t :tabnext<CR>
map <silent> [Tag]T :tabprevious<CR>

" Unite-tag
"let g:unite_source_tag_max_name_length=50
let g:unite_source_tag_max_fname_length=50
autocmd BufEnter *
			\   if empty(&buftype)
			\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
			\|  endif
autocmd BufEnter *
			\   if empty(&buftype)
			\|      nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
			\|  endif

" vim-submode
call submode#enter_with('resizewin', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('resizewin', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('resizewin', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('resizewin', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('resizewin', 'n', '', '>', '<C-w>>')
call submode#map('resizewin', 'n', '', '<', '<C-w><')
call submode#map('resizewin', 'n', '', '+', '<C-w>+')
call submode#map('resizewin', 'n', '', '-', '<C-w>-')
nnoremap <silent> <Tab>    <C-w>w
nnoremap <silent> <S-Tab>  <C-w>W

" AutoComplete
" 330行目らへんを修正してある
let g:AutoComplPop_IgnoreCaseOption = 0
let g:AutoComplPop_CompleteoptPreview = 1

" Command
"現バッファの差分表示
command! DiffOrig vert new | set bt=nofile | r # | -1d_ | diffthis | wincmd p | diffthis
"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif

