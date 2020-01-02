#!/usr/bin/env bash

set -e
set -x

# Install Tmux Plugin Manager
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
	mkdir --parents ~/.tmux/plugins
	git clone \
		https://github.com/tmux-plugins/tpm \
		~/.tmux/plugins/tpm
fi

# Install TPM plugins
export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins/
sh ~/.tmux/plugins/tpm/scripts/install_plugins.sh
