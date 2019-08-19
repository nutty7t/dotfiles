call plug#begin('~/.local/share/nvim/plugged')

" Tmux Integration {
	Plug 'christoomey/vim-tmux-navigator'
" }

" Git Integration {
	Plug 'tpope/vim-fugitive'     " git wrapper
	Plug 'airblade/vim-gitgutter' " git diff in gutter
" }

" Fuzzy Finding {
	Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
	Plug 'junegunn/fzf.vim'
" }

" NERDTree {
	Plug 'scrooloose/nerdtree'     " core plugin
	Plug 'jistr/vim-nerdtree-tabs' " tab integration
" }

" Auto-Completion / Syntax Highlighting {
	Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
	Plug 'cakebaker/scss-syntax.vim' " scss (sassy css)
	Plug 'digitaltoad/vim-pug'       " pug templating engine
	Plug 'posva/vim-vue'             " vue single-file components
" }

" Whitespace Management {
	Plug 'editorconfig/editorconfig-vim'  " style settings
	Plug 'ntpeters/vim-better-whitespace' " trailing whitespace
" }

" Markdown Preview {
	Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}
" }

" Utility {
	Plug 'mbbill/undotree'         " undo tree visualizer
	Plug 'junegunn/vim-easy-align' " easy alignment
	Plug 'justinmk/vim-sneak'      " sneak motion
	Plug 'tomtom/tcomment_vim'     " comment stuff out
	Plug 'tpope/vim-surround'      " surrounding pairs
	Plug 'tpope/vim-endwise'       " auto-closing structures
	Plug 'tpope/vim-repeat'        " repeating plugin maps
" }

call plug#end()

