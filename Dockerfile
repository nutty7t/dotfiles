FROM archlinux/base

# Install and update packages
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

# Setup timezone
RUN ln \
	--force \
	--symbolic \
	/usr/share/zoneinfo/America/Phoenix \
	/etc/localtime

