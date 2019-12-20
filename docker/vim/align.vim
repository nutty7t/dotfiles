" interactive visual mode
xnoremap ga <Plug>(EasyAlign)

" interactive motion
nnoremap ga <Plug>(EasyAlign)

" regular expression
vnoremap gar :EasyAlign <CR><C-x>

" Allow quotes to be aligned.
let g:easy_align_delimiters = {
\		'"': {
\			'pattern': '"',
\			'ignore_groups': []
\		},
\	}

