filetype plugin on
filetype indent on

autocmd FileType html :packadd coc-css
autocmd FileType html :packadd coc-emmet
autocmd FileType html :packadd coc-html

autocmd FileType css,less,sass :packadd coc-css
autocmd FileType css,less,sass :packadd coc-emmet

autocmd FileType typescript,typescriptreact :packadd coc-emmet
autocmd FileType typescript,typescriptreact :packadd coc-tslint
autocmd FileType typescript,typescriptreact :packadd coc-tslint-plugin
autocmd FileType typescript,typescriptreact :packadd coc-tslint-tsserver

autocmd FileType json :packadd coc-json

autocmd FileType yaml :packadd coc-yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
