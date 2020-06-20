filetype plugin on
filetype indent on

autocmd FileType html :packadd coc-css
autocmd FileType html :packadd coc-emmet
autocmd FileType html :packadd coc-html
autocmd FileType html :packadd emmet-vim

autocmd FileType css,less,sass :packadd coc-css
autocmd FileType css,less,sass :packadd coc-emmet
autocmd FileType css,less,sass :packadd emmet-vim

autocmd FileType typescript,typescriptreact :packadd coc-emmet
autocmd FileType typescript,typescriptreact :packadd coc-tslint
autocmd FileType typescript,typescriptreact :packadd coc-tslint-plugin
autocmd FileType typescript,typescriptreact :packadd coc-tslint-tsserver
autocmd FileType typescript,typescriptreact :packadd emmet-vim
autocmd FileType typescript,typescriptreact :packadd vim-jsx-pretty

autocmd FileType purescript :packadd purescript-vim
autocmd BufNewFile,BufRead *.purs set filetype=purescript

autocmd FileType json :packadd coc-json

autocmd FileType yaml :packadd coc-yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
