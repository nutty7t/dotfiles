" interactive visual mode
xmap ga <Plug>(EasyAlign)

" interactive motion
nmap ga <Plug>(EasyAlign)

" allow quotes to be aligned
let g:easy_align_delimiters = {
\		'"': {
\			'pattern': '"',
\			'ignore_groups': []
\		},
\	}
