#!/usr/bin/env bash

set -e
set -x

# Create some symbolic links, creating needless indirection, just
# because I prefer .vimrc over init.vim.
mkdir --parents ~/.config/nvim

ln \
	--force \
	--no-dereference \
	--symbolic \
	--verbose \
	~/Code/dotfiles/vim \
	~/.vimrc

ln \
	--force \
	--symbolic \
	--verbose \
	~/.vimrc/main.vim \
	~/.config/nvim/init.vim

# Install vim-plug.
curl \
	--create-dirs \
	--fail \
	--location \
	--output ~/.local/share/nvim/site/autoload/plug.vim \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Allow support for Python plugins in nvim.
# Required for deoplete.
pip3 install --user pynvim

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
nvim +PlugInstall +qall \
	&& nvim +PlugStatus +"w PlugStatus" +qall \
	&& (exit $( \
		cat PlugStatus \
		| head --lines=1 \
		| egrep --only-matching '[0-9+]' \
	)) \
	&& rm PlugStatus

