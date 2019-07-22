#!/usr/bin/env sh

# Install language server and all optional providers.
# See https://github.com/palantir/python-language-server.
pip3 install --user 'python-language-server[all]'

# Optional Static Typing.
pip3 install --user mypy

