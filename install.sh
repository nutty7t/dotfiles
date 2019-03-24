#!/usr/bin/env bash

set -e
set -x

# ----------------------------------------------------------------------
#  Generate the locale (tmux requires UTF-8)
# ----------------------------------------------------------------------

echo "en_US.UTF-8 UTF-8" >/etc/locale.gen
locale-gen

# ----------------------------------------------------------------------
#  Setup the timezone
# ----------------------------------------------------------------------

ln \
	--force \
	--symbolic \
	/usr/share/zoneinfo/America/Phoenix \
	/etc/localtime

# ----------------------------------------------------------------------
#  Install the system packages
# ----------------------------------------------------------------------

pacman \
	--noconfirm \
	--refresh \
	--sync \
	--sysupgrade

cat pkg/list.txt \
	| sed --regexp-extended '/^(#.*)?$/d' \
	| gawk '{ print $1 }' \
	| xargs \
		--max-args=1 \
		pacman \
			--needed \
			--noconfirm \
			--sync

# ----------------------------------------------------------------------
#  Create the nutty user with escalated privileges
# ----------------------------------------------------------------------

useradd \
	--create-home \
	--groups wheel \
	--shell /usr/bin/zsh \
	nutty || true

sed \
	--in-place \
	--regexp-extended \
	's/^# (%wheel ALL=\(ALL\) NOPASSWD: ALL)/\1/' \
	/etc/sudoers

# ----------------------------------------------------------------------
#  Symlink the dotfiles
# ----------------------------------------------------------------------

# (because we might run this as root)
export NUTTY_HOME="/home/nutty"

if [[ ! -d ${NUTTY_HOME}/dotfiles ]]; then
	git clone https://github.com/nutty7t/raspberry ${NUTTY_HOME}/dotfiles
else
	git -C ${NUTTY_HOME}/dotfiles pull
fi

find ${NUTTY_HOME}/dotfiles -name '*.symlink' \
	| xargs \
		--replace={} \
		--max-args=1 \
		bash -c 'ln \
			--force \
			--symbolic \
			--verbose \
			$(realpath {}) \
			/home/nutty/.$(basename {} .symlink)'

# ----------------------------------------------------------------------
#  Run the installation scripts
# ----------------------------------------------------------------------

find -name '_install.sh' | xargs --max-args=1 bash

# ----------------------------------------------------------------------
#  Output script success
# ----------------------------------------------------------------------

echo
printf "All done! ^.^\n"
printf "Don't forget to set nutty's password!\n"
echo

