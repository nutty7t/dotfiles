FROM nixos/nix

RUN apk update && apk add tzdata
RUN cp /usr/share/zoneinfo/America/Phoenix /etc/localtime

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
RUN nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
RUN nix-channel --update
RUN nix-shell '<home-manager>' -A install

COPY . /root/Code/dotfiles
RUN ln -sf /root/Code/dotfiles/dotfiles.nix /root/.config/nixpkgs/home.nix
RUN home-manager switch

RUN git clone --depth 1 https://github.com/hlissner/doom-emacs /root/.emacs.d
RUN /root/.emacs.d/bin/doom --yes install

WORKDIR /root

CMD [ "sleep", "infinity" ]
