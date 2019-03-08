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
RUN groupadd --system sudo && \
	useradd --create-home --groups sudo yay && \
	echo '%sudo ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# Install yay (AUR helper)
RUN git clone https://aur.archlinux.org/yay.git /home/yay/install && \
	chown yay /home/yay/install && \
	su \
		--login yay \
		--command="cd install && makepkg \
			--install \
			--noconfirm \
			--syncdeps" && \
	rm --recursive /home/yay/install

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

