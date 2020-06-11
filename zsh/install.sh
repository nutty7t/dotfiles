#!/usr/bin/env bash

set -e
set -x

# setup spaceship prompt
mkdir --parents "${HOME}/.zfunctions"
spaceship_zsh="${HOME}/.nix-profile/share/zsh/themes/spaceship.zsh-theme"
ln --force --symbolic "${spaceship_zsh}" "${HOME}/.zfunctions/prompt_spaceship_setup"
