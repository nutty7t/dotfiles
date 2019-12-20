#!/usr/bin/env bash

set -e
set -x

plugins="${HOME}/.zsh_plugins"

# ──────────────────────────────────────────────────────────────────────
#  Clone plugin repositories
# ──────────────────────────────────────────────────────────────────────

repositories=(
	'https://github.com/robbyrussell/oh-my-zsh'
	'https://github.com/zsh-users/zsh-autosuggestions'
	'https://github.com/zsh-users/zsh-syntax-highlighting'
	'https://github.com/denysdovhan/spaceship-prompt'
)

if [[ ! -d ${plugins} ]]; then
	mkdir ${plugins}
fi

for repository in ${repositories[@]}; do
	target="${plugins}/$(basename ${repository})"
	if [[ ! -d ${target} ]]; then
		# Install the plugin.
		git clone \
			${repository} \
			"${plugins}/$(basename ${repository})"
	else
		# Update the plugin from origin/HEAD.
		# [WARNING] Dangerous and might break things.
		cd ${target}
		git pull
		cd - >/dev/null
	fi
done

# ──────────────────────────────────────────────────────────────────────
#  Setup Spaceship ZSH prompt
# ──────────────────────────────────────────────────────────────────────

spaceship_zsh="${plugins}/spaceship-prompt/spaceship.zsh"
site_functions="/usr/local/share/zsh/site-functions"

sudo mkdir --parents ${site_functions}
sudo ln \
	--force \
	--symbolic \
	"${spaceship_zsh}" \
	"${site_functions}/prompt_spaceship_setup"

mkdir --parents ${HOME}/.zfunctions
ln \
	--force \
	--symbolic \
	"${spaceship_zsh}" \
	"${HOME}/.zfunctions/prompt_spaceship_setup"

