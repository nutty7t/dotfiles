{ config, lib, pkgs, ... }:
let
  osInfo = builtins.readFile /etc/os-release;
  isNixOS = builtins.match ".*([Nn]ix).*" osInfo != null;
in
  {
    programs.home-manager.enable = true;
    nixpkgs.config.allowUnfree = true;
    xdg.enable = true;

    home.username = "nutty";
    home.homeDirectory = "/home/nutty";
    home.stateVersion = "20.09";
    home.packages = [
      (pkgs.callPackage ./vim {})

      pkgs.bash
      pkgs.bat
      pkgs.bitwarden-cli
      pkgs.coreutils
      pkgs.docker
      pkgs.doctl
      pkgs.exa
      pkgs.fd
      pkgs.fontconfig
      pkgs.glibcLocales
      pkgs.htop
      pkgs.httpie
      pkgs.jq
      pkgs.kubectl
      pkgs.less
      pkgs.man-pages
      pkgs.nixops
      pkgs.openssh
      pkgs.ps
      pkgs.ripgrep
      pkgs.sops
      pkgs.wget

      pkgs.jetbrains.datagrip
      pkgs.jetbrains.idea-ultimate
      pkgs.jetbrains.webstorm
    ];

    imports = [
      ./emacs
      ./fish
      ./git
      ./gpg
      ./lang/haskell
      ./tmux
    ] ++ lib.optionals (!isNixOS) [
      # Only use fontconfig if we're not in NixOS.
      # NixOS can manage fonts by itself.
      ./fontconfig
    ];
  }
