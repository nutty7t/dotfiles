{ config, pkgs, ... }:
  {
    programs.home-manager.enable = true;
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
      pkgs.openssh
      pkgs.ps
      pkgs.ripgrep
      pkgs.wget
    ];

    imports = [
      ./emacs
      ./fish
      ./git
      ./gpg
      ./lang/haskell
      ./tmux
    ];
  }
