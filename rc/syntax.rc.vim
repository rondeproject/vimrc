"---------------------------------------------------------------------------
" Syntax:
"
set t_Co=256                " 256色

syntax on             " シンタックスカラーリングオン
colorscheme default   " 背景白用カラースキーム
highlight ShowMarksHLl ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight ShowMarksHLu ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight ShowMarksHLo ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight ShowMarksHLm ctermfg=black ctermbg=white cterm=bold guifg=black guibg=white gui=bold " ShowMarks用の色設定
highlight StatusLine   ctermfg=darkblue ctermbg=white term=bold,reverse cterm=bold,reverse gui=bold,reverse
highlight TabLineSel   ctermfg=darkblue ctermbg=white term=bold cterm=bold gui=bold

filetype indent on " ファイルタイプによるインデントを行う
filetype plugin on " ファイルタイプごとのプラグインを使う

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

" 自動で判断できない拡張子
autocmd MyAutoCmd BufRead,BufNewFile makefile.inc set filetype=make
autocmd MyAutoCmd BufRead,BufNewFile Makefile.inc set filetype=make

" Device Tree
autocmd MyAutoCmd BufRead,BufNewFile *.dts setf dts
autocmd MyAutoCmd BufRead,BufNewFile *.dtsi setf dts

