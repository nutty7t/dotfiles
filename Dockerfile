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

RUN fselect path from ~/Code/dotfiles \
	where name = '_install.sh' and \
	path != '*arch*' | xargs sh

