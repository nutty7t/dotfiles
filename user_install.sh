#!/usr/bin/env bash

set -e
set -x

# ----------------------------------------------------------------------
#  Symlink the dotfiles
# ----------------------------------------------------------------------

if [[ ! -d ~/dotfiles ]]; then
	git clone https://github.com/nutty7t/raspberry ~/dotfiles
else
	git -C ~/dotfiles pull
fi

find ~/dotfiles -name '*.symlink' \
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

