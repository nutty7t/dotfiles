FROM nixos/nix

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update

# install packages
COPY packages .
RUN nix-env --install $(cat packages)
RUN rm packages

# setup dotfiles
WORKDIR /root
RUN apk update && apk add sudo
RUN git clone https://github.com/nutty7t/dotfiles .dotfiles \
	&& cd .dotfiles/windows \
	&& nix-shell --run "zsh ./setup.sh"

# set timezone
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/America/Phoenix /etc/localtime

CMD ["sleep", "infinity"]
