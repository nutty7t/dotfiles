#!/usr/bin/env bash

# shellcheck disable=SC2016
symlink_command='ln --force --symbolic --verbose {} ~/.$(basename {} .symlink)'

# Symlink all *.symlink files to ~
# E.g. ./foo/bar.symlink -> ~/.bar
fselect path from ~/.dotfiles where name = '*.symlink' \
	| xargs \
		--replace={} \
		--max-args=1 \
		bash -c "${symlink_command}"

# Run all installation scripts
fselect path from ~/.dotfiles/windows where name = '_install.sh' \
	| xargs --max-args=1 bash
