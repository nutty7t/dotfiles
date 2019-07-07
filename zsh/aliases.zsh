alias reload!='clear && source ~/.zshrc'

# Commented out until the following issue gets resolved:
# https://github.com/ogham/exa/issues/517
# alias ls='exa --group-directories-first'
# alias la='exa --group-directories-first --all'
# alias ll='exa --group-directories-first --long'
# alias lst='exa --group-directories-first --tree'
# alias llt='exa --group-directories-first --long --tree'

# Until then, just use coreutils ls.
alias ls='ls --color=auto'
alias la='ls --group-directories-first --all'
alias ll='ls --group-directories-first -l'

alias cp='cp --interactive --verbose'
alias mv='mv --interactive --verbose'
alias mkdir='mkdir --parents --verbose'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cat='bat'
alias vim='nvim'
alias vimfzf='vim $(fzf)'
alias neofetch='echo && neofetch'

# ═══════════ [WARNING] ═══════════ #
#                                   #
#     These probably aren't very    #
#  politically correct alias names  #
#                                   #
# ═══════════ [WARNING] ═══════════ #

function __man {
	man $* \
		| col --no-backspaces \
		| nvim -R -c 'set ft=man nomod nolist' -
}

function __woman {
	tldr $1 | head --lines=-3
}

alias man='__woman'
alias woman='__man'

