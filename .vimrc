" vim-tiny or vim-small は読み込まない
if !1 | finish | endif

function! s:source_rc(path)
	execute 'source' fnameescape(expand('~/.vim/rc/' . a:path))
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
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'

" Help for Japanise
NeoBundle 'vim-jp/vimdoc-ja'

" NERDTree
"NeoBundle 'scrooloose/nerdtree'
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

" vim-submode
NeoBundle 'kana/vim-submode'

" QuickRun
NeoBundle 'thinca/vim-quickrun'

" Unite
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" Filer
NeoBundle 'Shougo/vimfiler'

" FuzzyFinder
NeoBundle 'L9'
NeoBundle 'FuzzyFinder'
NeoBundle 'QuickBuf'

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

" ShowMarks
NeoBundle "ShowMarks"

" BlockDiff
NeoBundle "BlockDiff"

call neobundle#end()
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
"NeoBundleCheck


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

