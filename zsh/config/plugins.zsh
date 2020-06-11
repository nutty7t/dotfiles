plugins="$HOME/.nix-profile/share"

if [[ -d ${plugins} ]]; then
	source ${plugins}/zsh-autosuggestions/zsh-autosuggestions.zsh
	source ${plugins}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	source ${plugins}/zsh-nix-shell/nix-shell.plugin.zsh
	source ${plugins}/zsh/plugins/nix/nix-zsh-completions.plugin.zsh
fi
