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

