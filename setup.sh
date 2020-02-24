#!/usr/bin/env bash

set -e
set -x

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
#
# [TODO] Some installation scripts depend on other installation scripts.
# E.g. vim/_install.sh depends on node/_install.sh.
#
# Coincidentally, lexicographically sorting the results from fselect yields a
# valid topological sorting of this implicit dependency graph. We'll want to
# eventually make this graph explicit, and resolve the dependencies properly.
fselect path from ~/.dotfiles where name = '_install.sh' \
	| sort \
	| xargs --max-args=1 bash
