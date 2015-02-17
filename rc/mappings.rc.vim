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


