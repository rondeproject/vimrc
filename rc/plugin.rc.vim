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
	autocmd MyAutoCmd VimEnter * execute 'NERDTree'
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
	nnoremap <silent> [unite]G :<C-u>Unite grep:. -buffer-name=search-buffer -no-quit<CR>
	nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
	nnoremap <silent> [unite]F :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
	nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register history/yank<CR>
	nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
	nnoremap <silent> [unite]w :<C-u>Unite window<CR>
	autocmd MyAutoCmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
	autocmd MyAutoCmd FileType unite nnoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
	autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <expr> <C-k> unite#do_action('vsplit')
	autocmd MyAutoCmd FileType unite inoremap <silent> <buffer> <expr> <C-CR> unite#do_action('persist_open')
endif "}}}


"" =========================================================================
" VimFiler:
if neobundle#tap("vimfiler") "{{{
	let g:vimfiler_as_default_explorer = 1
	let g:vimfiler_force_overwrite_statusline = 0
	nnoremap <silent> <C-e> :VimFilerExplorer<CR>

	augroup MyAutoCmd
		" オープンは、<CR>(enter キー)
		autocmd FileType vimfiler nmap <buffer><expr> <CR>
					\ vimfiler#smart_cursor_map("\<Plug>(vimfiler_smart_l)", "\<Plug>(vimfiler_edit_file)")
		" 親ディレクトリ移動
		autocmd FileType vimfiler nmap <buffer><expr> <BS>
					\ '<Plug>(vimfiler_smart_h)'
"		" カレントディレクトリ移動
"		autocmd FileType vimfiler nmap <silent> <C-c> :<C-u>Unite -default-action=lcd directory_mru<CR>
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
" Unite-tag:
if neobundle#tap("unite-tag") "{{{
"	let g:unite_source_tag_max_name_length=50
	let g:unite_source_tag_max_fname_length=50
	autocmd MyAutoCmd BufEnter *
			\   if empty(&buftype)
			\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -buffer-name=tag -immediately tag tag/include<CR>
			\|  endif
	autocmd MyAutoCmd BufEnter *
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
" ssh yank:
let g:y2r_config = {
            \   'tmp_file': '/tmp/exchange_file',
            \   'key_file': expand('$HOME') . '/.exchange.key',
            \   'host': 'localhost',
            \   'port': 52224,
            \}

function Yank2Remote()
    call writefile(split(@", '\n'), g:y2r_config.tmp_file, 'b')
    let s:params = ['cat %s %s | nc -w1 %s %s']
    for s:item in ['key_file', 'tmp_file', 'host', 'port']
        let s:params += [shellescape(g:y2r_config[s:item])]
    endfor
    let s:ret = system(call(function('printf'), s:params))
endfunction

nnoremap <silent> <unique> <Leader>y :call Yank2Remote()<CR>


"" =========================================================================
" AutoComplete:
" 330行目らへんを修正してある
let g:AutoComplPop_IgnoreCaseOption = 0
let g:AutoComplPop_CompleteoptPreview = 1


""---------------------------------------------------------------------------
" Command:
"現バッファの差分表示
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d__ | diffthis | wincmd p | diffthis
"ファイルまたはバッファ番号を指定して差分表示。#なら裏バッファと比較
command! -nargs=? -complete=file Diff if '<args>'=='' | browse vertical diffsplit|else| vertical diffsplit <args>|endif


"" =========================================================================
" Other:
" 日本語ヘルプが有効にならない
helptags $CACHE/bundle/vimdoc-ja/doc/

