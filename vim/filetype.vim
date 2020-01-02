filetype on
filetype plugin on
filetype indent on

" Vue -- disabled preprocessors (b/c freaking slow)
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors = 1

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
