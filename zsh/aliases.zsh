alias reload!='clear && source ~/.zshrc'
alias dotfiles='cd ~/.dotfiles'
alias explorer='explorer.exe .'

alias ls='exa --group-directories-first'
alias la='exa --group-directories-first --all'
alias ll='exa --group-directories-first --long'
alias lst='exa --group-directories-first --tree'
alias llt='exa --group-directories-first --long --tree'

alias cp='cp --interactive --verbose'
alias mv='mv --interactive --verbose'
alias mkdir='mkdir --parents --verbose'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
alias vimfzf='vim $(fzf)'

alias cat='bat'
alias vim='nvim'
alias neofetch='echo && neofetch'

# Let tmux know that the terminal supports 256 colors.
# Run with Unicode support.
alias tmux='TERM=xterm-256color tmux -u'
