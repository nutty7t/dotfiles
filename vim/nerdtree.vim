nnoremap <LEADER>tt :NERDTreeTabsToggle <CR>
vnoremap <LEADER>tt :NERDTreeTabsToggle <CR>

let NERDTreeMinimalUI = 1       " hide help string
let NERDTreeShowLineNumbers = 0 " hide line numbers

" Automatically find and select currently opened file in NERDTree.
let g:nerdtree_tabs_autofind = 1

" Close vim if the only window left open is a NERDTree.
function NERDTreeExit()
	if (winnr('$') == 1
	\	&& exists('b:NERDTree')
	\	&& b:NERDTree.isTabTree())
		q
	endif
endfunction

autocmd BufEnter * call NERDTreeExit()

