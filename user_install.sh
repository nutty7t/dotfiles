#!/usr/bin/env bash

set -e
set -x

# ----------------------------------------------------------------------
#  Symlink the dotfiles
# ----------------------------------------------------------------------

if [[ ! -d ~/Code/dotfiles ]]; then
	git clone https://github.com/nutty7t/dotfiles ~/Code/dotfiles
	git -C ~/Code/dotfiles checkout raspberry
else
	git -C ~/Code/dotfiles pull
fi

find ~/Code/dotfiles -name '*.symlink' \
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
echo "All done! ^.^"
echo

