" Use <TAB> to trigger completion.
inoremap <silent><expr> <TAB>
\	pumvisible() ? "\<C-n>" :
\	<SID>check_back_space() ? "\<TAB>" :
\	coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Goto Mappings.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

