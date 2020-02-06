#!/usr/bin/env bash

set -e
set -x

# Create some symbolic links, creating needless indirection, just
# because I prefer .vimrc over init.vim.
rm --force --recursive ~/.vimrc
mkdir --parents ~/.config/nvim \
	&& ln --force --symbolic ~/.dotfiles/vim ~/.vimrc \
	&& ln --force --symbolic ~/.vimrc/main.vim ~/.config/nvim/init.vim

# Install vim-plug.
curl \
	--create-dirs \
	--fail \
	--location \
	--output ~/.local/share/nvim/site/autoload/plug.vim \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugins. nvim won't exit with a non-zero exit code if
# +PlugInstall fails so the output of +PlugStatus needs to be parsed in
# order to determine whether the installation succeeded or not.
#
#    Finished. 0 error(s).
#    [====================]
#
#    - foobar: OK
#    - bazqux: OK
#        .     .
#        .     .
#        .     .
#
# In a subshell, exit with the status code as the number of errors that
# occurred when checking the status of the plugins so that the docker
# build fails if there are any errors.
#
# NOTE: Sometimes, +PlugStatus aborts with what seems to be a benign
# segmentation fault.
nvim +PlugInstall +qall \
	&& (nvim +PlugStatus +"w PlugStatus" +qall || true) \
	&& (exit $( \
		cat PlugStatus \
		| head --lines=1 \
		| egrep --only-matching '[0-9+]' \
	)) \
	&& rm PlugStatus

# Symlink Coc.nvim settings file.
ln \
	--force \
	--symbolic \
	~/.dotfiles/vim/completion.json \
	~/.config/nvim/coc-settings.json

# Install language servers (assuming that node/_install.sh executed).
npm install --global bash-language-server
npm install --global dockerfile-language-server-nodejs
npm install --global purescript-language-server
npm install --global vue-language-server

# Install Coc.nvim extensions.
mkdir --parents ~/.config/coc/extensions
pushd ~/.config/coc/extensions
if [ ! -f package.json ]; then
	echo '{"dependencies":{}}' >package.json
fi
npm install \
	coc-json \
	coc-prettier \
	coc-python \
	coc-tsserver \
	coc-vetur \
	coc-yaml
popd
