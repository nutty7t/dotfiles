#!/usr/bin/env bash

set -e
set -x

# Install Tmux Plugin Manager
if [[ ! -d ${NUTTY_HOME}/.tmux/plugins/tpm ]]; then
	mkdir --parents ${NUTTY_HOME}/.tmux/plugins
	git clone \
		https://github.com/tmux-plugins/tpm \
		${NUTTY_HOME}/.tmux/plugins/tpm
fi

# Install TPM plugins
export TMUX_PLUGIN_MANAGER_PATH=${NUTTY_HOME}/.tmux/plugins/
sh ${NUTTY_HOME}/.tmux/plugins/tpm/scripts/install_plugins.sh

