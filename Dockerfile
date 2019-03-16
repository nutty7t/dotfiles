FROM archlinux/base

# ──────────────────────────────────────────────────────────────────────
#  Install packages
# ──────────────────────────────────────────────────────────────────────

COPY arch tmp
RUN tmp/_install.sh \
	&& rm --recursive tmp/*

# ──────────────────────────────────────────────────────────────────────
#  Install dotfiles
# ──────────────────────────────────────────────────────────────────────

USER nutty
WORKDIR /home/nutty

RUN mkdir ~/Code && git clone \
	https://github.com/nutty7t/dotfiles \
	~/Code/dotfiles

# Symlink all *.symlink files to ~
# E.g. ./foo/bar.symlink -> ~/.bar
RUN fselect path from ~/Code/dotfiles \
	where name = '*.symlink' | xargs \
		--replace={} \
		--max-args=1 \
		bash -c 'ln \
			--force \
			--symbolic \
			--verbose \
			{} \
			~/.$(basename {} .symlink)'

# Run all installation scripts
RUN fselect path from ~/Code/dotfiles \
	where name = '_install.sh' and \
	path != '*arch*' | xargs --max-args=1 bash

CMD ["tmux"]

