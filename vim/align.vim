xnoremap ga <Plug>(EasyAlign)     " interactive visual mode
nnoremap ga <Plug>(EasyAlign)     " interactive motion
vnoremap gar :EasyAlign <CR><C-x> " regular expressions

" Allow quotes to be aligned.
let g:easy_align_delimiters = {
\		'"': {
\			'pattern': '"',
\			'ignore_groups': []
\		},
\	}

