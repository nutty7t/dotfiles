FROM nixos/nix

RUN apk update
RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update

# install packages
COPY packages .
RUN nix-env --install $(cat packages)
RUN rm packages

# setup dotfiles
RUN apk add sudo
RUN git clone https://github.com/nutty7t/dotfiles ~/.dotfiles \
	&& mkdir ~/Code \
	&& ln --symbolic ~/.dotfiles ~/Code/dotfiles \
	&& cd ~/Code/dotfiles \
	&& nix-shell --run "zsh ./setup.sh"

# set timezone
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/America/Phoenix /etc/localtime

WORKDIR /root
CMD ["sleep", "infinity"]
