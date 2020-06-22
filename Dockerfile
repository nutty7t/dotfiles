FROM nixos/nix

RUN apk update && apk add tzdata
RUN cp /usr/share/zoneinfo/America/Phoenix /etc/localtime

COPY . /root/.dotfiles
WORKDIR /root/.dotfiles

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --update
RUN nix-env --install --file default.nix

WORKDIR /root

CMD ["sleep", "infinity"]
