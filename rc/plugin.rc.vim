"---------------------------------------------------------------------------
" Plugin:
"

"" =========================================================================
" NERD_comments:
if neobundle#tap("nerdcommenter") "{{{
	let g:NERDCreateDefaultMappings = 0
	let NERDSpaceDelims = 1
	let NERDShutup = 1
	nmap <silent> <Space>/ <Plug>NERDCommenterToggle
	vmap <silent> <Space>/ <Plug>NERDCommenterToggle
endif "}}}


"" =========================================================================
" NERD_tree:
if neobundle#tap("nerdtree") "{{{
	let NERDTreeShowHidden = 1
	nnoremap <silent> <C-e> :NERDTreeToggle<CR>
	autocmd VimEnter * execute 'NERDTree'
endif "}}}


"" =========================================================================
" Unite:
if neobundle#tap("unite.vim") "{{{
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
	nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer -no-quit<CR>
	nnoremap <silent> [unite]F :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
	nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register history/yank<CR>
	nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
	nnoremap <silent> [unite]w :<C-u>Unite window<CR>
	autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
	autocmd FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
endif "}}}


"" =========================================================================
" VimFiler:
if neobundle#tap("vimfiler") "{{{
	let g:vimfiler_as_default_explorer = 1
	let g:vimfiler_force_overwrite_statusline = 1
	nnoremap <silent> <C-e> :VimFilerExplorer<CR>

	augroup vimfiler
		autocmd!
		" オープンは、<CR>(enter キー)
		autocmd FileType vimfiler nmap <buffer><expr> <CR>
					\ vimfiler#smart_cursor_map("\<Plug>(vimfiler_smart_l)", "\<Plug>(vimfiler_edit_file)")
		" 親ディレクトリ移動
		autocmd FileType vimfiler nmap <buffer><expr> <BS>
					\ '<Plug>(vimfiler_smart_h)'
	augroup END
endif "}}}


"" =========================================================================
" grep:
if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif


"" =========================================================================
" QuickRun:
let quickrun_no_default_key_mappings=1
silent! map <unique> <F7> <Plug>(quickrun)


"" =========================================================================
" Gundo:
if neobundle#tap("gundo.vim") "{{{
	nnoremap <silent> <F3> :GundoToggle<CR>
endif "}}}


"" =========================================================================
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


"" =========================================================================
" Unite-tag:
if neobundle#tap("unite-tag") "{{{
"	let g:unite_source_tag_max_name_length=50
	let g:unite_source_tag_max_fname_length=50
	autocmd BufEnter *
			\   if empty(&buftype)
			\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -buffer-name=tag -immediately tag tag/include<CR>
			\|  endif
	autocmd BufEnter *
			\   if empty(&buftype)
			\|      nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
			\|  endif
endif "}}}


"" =========================================================================
" vim-submode:
if neobundle#tap("vim-submode") "{{{
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
endif "}}}


"" =========================================================================
" ShowMarks:
if neobundle#tap("ShowMarks") "{{{
	let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
endif "}}}


"" =========================================================================
" AutoComplete:
" 330行目らへんを修正してある
let g:AutoComplPop_IgnoreCaseOption = 0
let g:AutoComplPop_CompleteoptPreview = 1

