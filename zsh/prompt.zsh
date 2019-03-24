# ──────────────────────────────────────────────────────────────────────
#  Spaceship Prompt.
# ──────────────────────────────────────────────────────────────────────

fpath=("${HOME}/.zfunctions" ${fpath})
autoload -U promptinit; promptinit
prompt spaceship

SPACESHIP_CHAR_SYMBOL=":: "
SPACESHIP_PROMPT_ORDER=(
	dir
	vi_mode
	char
)

