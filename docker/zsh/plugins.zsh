# ──────────────────────────────────────────────────────────────────────
#  Source the plugins.
# ──────────────────────────────────────────────────────────────────────

plugins="$HOME/.zsh_plugins"

if [[ -d ${plugins} ]]; then
	source ${plugins}/zsh-autosuggestions/zsh-autosuggestions.zsh
	source ${plugins}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source ${plugins}/oh-my-zsh/plugins/git/git.plugin.zsh
	source ${plugins}/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh
fi

