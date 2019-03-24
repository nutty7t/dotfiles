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

" Auto-Completion {
	Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
	Plug 'zchee/deoplete-go', { 'do': 'make'} " golang
	Plug 'slashmili/alchemist.vim'            " elixir
	Plug 'zchee/deoplete-jedi'                " python
" }

" Whitespace Management {
	Plug 'editorconfig/editorconfig-vim'  " style settings
	Plug 'ntpeters/vim-better-whitespace' " trailing whitespace
	Plug 'Yggdroot/indentLine'            " display indentation levels
" }

" Utility {
	Plug 'mbbill/undotree'         " undo tree visualizer
	Plug 'junegunn/vim-easy-align' " easy alignment
	Plug 'justinmk/vim-sneak'      " sneak motion
	Plug 'tpope/vim-surround'      " surrounding pairs
	Plug 'tpope/vim-commentary'    " comment stuff out
	Plug 'tpope/vim-endwise'       " auto-closing structures
	Plug 'tpope/vim-repeat'        " repeating plugin maps
" }

call plug#end()
