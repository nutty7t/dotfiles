#!/usr/bin/env bash

set -e
set -x

# symlink coc-settings.json -- this is temporary!
#
# the plan is to eventually create a nix derivation containing all of the files
# that need to be installed into the home directory; inside the nix derivation
# will be a script that will perform all of the symlinking.
mkdir --parents "${HOME}/.config/nvim"
ln --force --symbolic \
	"${HOME}/.dotfiles/vim/config/completion.json" \
	"${HOME}/.config/nvim/coc-settings.json"
