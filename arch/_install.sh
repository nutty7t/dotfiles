#!/usr/bin/env bash

set -e
set -x

# ──────────────────────────────────────────────────────────────────────
#  Setup timezone
# ──────────────────────────────────────────────────────────────────────

ln \
	--force \
	--symbolic \
	/usr/share/zoneinfo/America/Phoenix \
	/etc/localtime

# ──────────────────────────────────────────────────────────────────────
#  Create users
# ──────────────────────────────────────────────────────────────────────

# Running makepkg is disallowed as root, and yay refuses to install AUR
# packages as root. To workaround this, a normal user (named 'yay') is
# created with superuser privileges for the sole purpose of installing
# and running yay.
groupadd --system sudo \
	&& useradd --create-home --groups sudo yay \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# Create nutty user (that's me!)
useradd --create-home --groups sudo nutty \
	&& echo '%sudo ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

# ──────────────────────────────────────────────────────────────────────
#  Install packages
# ──────────────────────────────────────────────────────────────────────

# Upgrade system and install build tools
pacman \
	--needed \
	--noconfirm \
	--refresh \
	--sync \
	--sysupgrade \
	base \
	base-devel \
	git

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay.git /home/yay/install \
	&& chown yay /home/yay/install \
	&& su \
		--login yay \
		--command="cd install && makepkg \
			--install \
			--noconfirm \
			--syncdeps" \
	&& rm --recursive /home/yay/install

# Parse package lists
sed \
	--in-place \
	--regexp-extended \
	'/^(#.*)?$/d' \
	$(dirname $0)/packages/*

gawk \
	--include inplace \
	'{ print $1 }' \
	$(dirname $0)/packages/*

# Install official packages
pacman \
	--needed \
	--noconfirm \
	--sync \
	- <$(dirname $0)/packages/official.txt

# Install AUR packages
su \
	--login yay \
	--command="yay \
		--needed \
		--noconfirm \
		--sync \
		$(cat $(dirname $0)/packages/user.txt | tr '\n' ' ')"

