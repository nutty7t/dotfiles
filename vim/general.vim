" Persistence {
	set hidden       " enable hidden buffers
	set confirm      " confirm unsaved changes
	set autowrite    " automatically save files
	set autowriteall " automatically save all files
	set autoread     " automatically reload files

	if has('persistent_undo')
		silent call mkdir(expand('~') . '/.vim/backups', 'p')
		set undodir=~/.vim/backups
		set undofile
	endif

	" Disable annoying swap and backup files -- don't need them when
	" files are backed up with persistent undo trees, autowriting, and
	" version control software.

	set noswapfile
	set nobackup
	set nowritebackup
" }

" Whitespace Management {
	set listchars=tab:▸\   " invisible characters
	set listchars+=space:· " toggle with :set list!

	" Tabs for semantic indentation.
	" Spaces for presentational indentation.
	" But EditorConfig is the supreme being.

	set smarttab     " >9000 IQ
	set tabstop=4    " set tab width
	set shiftwidth=4 " set auto-indent width
	set noexpandtab  " don't expand tabs by default
" }

" Searching {
	set magic      " regular expressions
	set incsearch  " incremental search
	set hlsearch   " highlight search results
	set ignorecase " ignore case when searching...
	set smartcase  " ...unless we type a capital letter
" }

" Usability {
	set nostartofline    " remember column when switching buffers
	set nowrap           " don't wrap lines by default
	set notimeout        " combination of notimeout and ttimeout
	set ttimeout         " => timeout on key codes ∧
	set ttimeoutlen=10   "    no timeout on mappings
	set updatetime=100   " event loop update time
	set inccommand=split " preview subsitution in split
	set scrolloff=5      " scroll offset from buffer edges
	set sidescroll=1     " enable horizontal side-scrolling
	set mouse=a          " enable mouse support
	set complete-=i      " disable scanning of include files
	set backspace=indent " allow backspacing over autoindent
	set backspace+=eol   " allow backspacing over line breaks
	set backspace+=start " allow backspacing over start of insert
" }

" Mappings {
	" escape from the home row
	inoremap fd <ESC>
	vnoremap fd <ESC>

	" leader key
	let mapleader=" "

	" sudo write file
	cnoremap w!! w !sudo tee % >/dev/null

	" toggle line wrapping
	nnoremap <LEADER>tl :set wrap!<CR>

	" toggle whitespace
	nnoremap <LEADER>tw :set list!<CR>

	" toggle paste mode
	nnoremap <LEADER>tp :set invpaste<CR>

	" clear search highlighting
	nnoremap // :noh<CR>
" }

