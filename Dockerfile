FROM archlinux/base

# Upgrade system and install build tools
RUN pacman \
	--needed \
	--noconfirm \
	--refresh \
	--sync \
	--sysupgrade \
	base-devel \
	git

# Running makepkg is disallowed as root, and yay refuses to install AUR
# packages as root. To workaround this, a normal user (named 'yay') is created
# with superuser privileges for the sole purpose of installing and running yay.
RUN groupadd --system sudo \
	&& useradd --create-home --groups sudo yay \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# Install yay (AUR helper)
RUN git clone https://aur.archlinux.org/yay.git /home/yay/install \
	&& chown yay /home/yay/install \
	&& su \
		--login yay \
		--command="cd install && makepkg \
			--install \
			--noconfirm \
			--syncdeps" \
	&& rm --recursive /home/yay/install

# Install packages
RUN mkdir packages
COPY packages packages

RUN sed \
	--in-place \
	--regexp-extended \
	'/^(#.*)?$/d' \
	packages/*

RUN gawk \
	--include inplace \
	'{ print $1 }' \
	packages/*

RUN pacman \
	--needed \
	--noconfirm \
	--sync \
	- <packages/official.txt

RUN su \
	--login yay \
	--command="yay \
		--needed \
		--noconfirm \
		--sync \
		$(cat packages/user.txt | tr '\n' ' ')"

RUN rm --recursive packages

# Setup timezone
RUN ln \
	--force \
	--symbolic \
	/usr/share/zoneinfo/America/Phoenix \
	/etc/localtime

# Add nutty user (that's me!)
RUN useradd --create-home --groups sudo nutty \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER nutty

# Install dotfiles
RUN mkdir /home/nutty/Code
WORKDIR /home/nutty/Code
RUN git clone https://github.com/nutty7t/dotfiles

# (just because I prefer .vimrc over init.vim)
RUN mkdir --parents ~/.config/nvim
RUN ln --force --symbolic ~/Code/dotfiles/vim ~/.vimrc
RUN ln --force --symbolic ~/.vimrc/main.vim ~/.config/nvim/init.vim

# Install vim-plug
RUN curl \
	--create-dirs \
	--fail \
	--location \
	--output ~/.local/share/nvim/site/autoload/plug.vim \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install vim plugins. nvim won't exit with a non-zero exit code if
# +PlugInstall fails so the output of +PlugStatus needs to be parsed in order
# to determine whether the installation succeeded or not.
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
# occurred when checking the status of the plugins so that the docker build
# fails if there are any errors.
RUN nvim +PlugInstall +qall \
	&& nvim +PlugStatus +"w PlugStatus" +qall \
	&& (exit $( \
		cat PlugStatus \
		| head --lines=1 \
		| egrep --only-matching '[0-9+]' \
	))

