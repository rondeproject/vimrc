"---------------------------------------------------------------------------
" Key-mappings:
"

"" =========================================================================
" Move key
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk


"" =========================================================================
" Disable Hilight
"nmap <silent> <ESC><ESC> :nohlsearch<CR>


"" =========================================================================
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap        t       [Tag]

" Tab jump
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
	execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]w :tabclose<CR>
map <silent> [Tag]t :tabnext<CR>
map <silent> [Tag]T :tabprevious<CR>

" バイナリモード
augroup BinaryXXD
    autocmd!
""  autocmd BufReadPre  *.bin let &binary =1
    autocmd BufReadPost  * if &binary | silent %!xxd -g 1
    autocmd BufReadPost  * set ft=xxd | endif
    autocmd BufWritePre  * if &binary | silent %!xxd -r
    autocmd BufWritePre  * endif
    autocmd BufWritePost * if &binary | silent %!xxd -g 1
    autocmd BufWritePost * set nomod | endif
augroup END

