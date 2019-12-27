#!/usr/bin/env bash

# https://nixos.wiki/wiki/Node.js
npm set prefix ~/.npm-global
if [[ ! -d ~/.npm-global ]]; then
	mkdir ~/.npm-global
fi
