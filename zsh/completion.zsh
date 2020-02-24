# load completion listing extensions
zmodload zsh/complist

# shift+tab to go backwards in menu
bindkey -M menuselect '^[[Z' reverse-menu-complete

# menu-style autocompletion
zstyle ':completion:*' menu select

# case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# case-insensitive (all) completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# case-insensitive, partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# kubectl completion
source <(kubectl completion zsh)
