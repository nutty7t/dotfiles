#!/usr/bin/env sh

# TODO: Figure out how to install npm packages globally without sudo.

# NPM runs globally installed module scripts as the `nobody` user,
# but NPM also sets file permissions for node_modules for the `root`
# user. This means that scripts running as `nobody` can't write files.
# This is a workaround:
#
# https://stackoverflow.com/a/45505787
sudo npm -g config set user root

# Bash language server.
sudo npm install -g bash-language-server

# Dockerfile language server.
sudo npm install -g dockerfile-language-server-nodejs

# Vue language server.
sudo npm install -g vue-language-server

# PureScript.
# https://github.com/commercialhaskell/stack/issues/1012
# https://github.com/purescript/documentation/issues/119
#
# TODO: For some reason, spago doesn't seem to work.
# It works fine when I download the binary, but the command
# is a noop when I install from npm.
sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
sudo npm install -g purescript
sudo npm install -g bower pulp

