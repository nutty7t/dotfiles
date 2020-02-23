# ----------------------------------------------------------------------
#  Source the plugins.
# ----------------------------------------------------------------------

plugins="$HOME/.zsh_plugins"

# We're not using Oh-My-Zsh so $ZSH_CACHE_DIR never gets set, but the
# kubectl plugin uses this directory to enable kubectl autocompletion.
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh#L1-L6
ZSH_CACHE_DIR=$(mktemp --directory)

if [[ -d ${plugins} ]]; then
	source ${plugins}/zsh-autosuggestions/zsh-autosuggestions.zsh
	source ${plugins}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source ${plugins}/oh-my-zsh/plugins/git/git.plugin.zsh
	source ${plugins}/oh-my-zsh/plugins/kubectl/kubectl.plugin.zsh
	source ${plugins}/oh-my-zsh/plugins/vi-mode/vi-mode.plugin.zsh
	source ${plugins}/zsh-nix-shell/nix-shell.plugin.zsh
fi
