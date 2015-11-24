" vim-tiny or vim-small は読み込まない
if !1 | finish | endif

function! s:source_rc(path)
	execute 'source' fnameescape(expand('$HOME/.vim/rc/' . a:path))
endfunction

"---------------------------------------------------------------------------
" Initialize:
call s:source_rc('init.rc.vim')

"-------------------------------------------------------
" NeoBundle設定
"-------------------------------------------------------
" bundleで管理するディレクトリを指定
set runtimepath+=$CACHE/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('$CACHE/bundle/'))
 
if neobundle#load_cache()
	" neobundle自体をneobundleで管理
	NeoBundleFetch 'Shougo/neobundle.vim'

	" Help for Japanise
	NeoBundle 'vim-jp/vimdoc-ja'

	" NERDTree
"	NeoBundleLazy 'scrooloose/nerdtree'
	NeoBundleLazy 'scrooloose/nerdcommenter'

	" Grep
"	NeoBundle 'grep.vim'
"	NeoBundle 'rking/ag.vim'

	" vimproc
	NeoBundle 'Shougo/vimproc', {
				\  'build' : {
				\    'cygwin' : 'make -f make_cygwin.mak',
				\    'linux' : 'make -f make_unix.mak',
				\  }
				\}

	" Unite
	NeoBundleLazy 'Shougo/unite.vim'
	NeoBundleLazy 'Shougo/neomru.vim', { 'depends' : [ 'Shougo/unite.vim' ] }
	NeoBundleLazy 'ujihisa/unite-colorscheme', { 'depends' : [ 'Shougo/unite.vim' ] }

	" QuickRun
	NeoBundleLazy 'thinca/vim-quickrun'

	" Filer
	NeoBundleLazy 'Shougo/vimfiler', { 'depends' : [ 'Shougo/unite.vim' ] }

	" FuzzyFinder
"	NeoBundle 'L9'
"	NeoBundle 'FuzzyFinder'
"	NeoBundle 'QuickBuf'

	" Capture
	NeoBundleLazy 'tyru/capture.vim'

	" Gundo
	NeoBundleLazy 'sjl/gundo.vim'

	" VimCalc
	NeoBundleLazy 'gregsexton/VimCalc'

	" Tag
	NeoBundleLazy "tsukkee/unite-tag", { 'depends' : [ 'Shougo/unite.vim' ] }

	" vim-submode
	NeoBundle 'kana/vim-submode'

	" SVN
	NeoBundleLazy "kmnk/vim-unite-svn", { 'depends' : [ 'Shougo/unite.vim' ] }

	" GIT
	NeoBundleLazy 'kmnk/vim-unite-giti.git', { 'depends' : [ 'Shougo/unite.vim' ] }

	" ColorScheme
	NeoBundle "w0ng/vim-hybrid"
	NeoBundle "nanotech/jellybeans.vim"

	" ShowMarks
	NeoBundle "ShowMarks"

	" BlockDiff
	NeoBundleLazy "adie/BlockDiff"

	" Cacheの保存
	NeoBundleSaveCache
endif



"---------------------------------------------------------------------------
" Encoding:
call s:source_rc('encoding.rc.vim')

""---------------------------------------------------------------------------
" Edit:
call s:source_rc('edit.rc.vim')

""---------------------------------------------------------------------------
" View:
call s:source_rc('view.rc.vim')

""---------------------------------------------------------------------------
" Mapping:
call s:source_rc('mappings.rc.vim')

""---------------------------------------------------------------------------
" Syntax:
call s:source_rc('syntax.rc.vim')

""---------------------------------------------------------------------------
" Plugin:
call s:source_rc('plugin.rc.vim')

call neobundle#end()
