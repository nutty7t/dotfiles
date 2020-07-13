{ config, pkgs, ... }:
  {
    programs.home-manager.enable = true;

    home.username = "nutty";
    home.homeDirectory = "/home/nutty";
    home.stateVersion = "20.09";
    home.packages = [
      (pkgs.callPackage ./vim {})

      pkgs.bash
      pkgs.bat
      pkgs.coreutils
      pkgs.docker
      pkgs.doctl
      pkgs.emacs
      pkgs.exa
      pkgs.htop
      pkgs.httpie
      pkgs.jq
      pkgs.kubectl
      pkgs.less
      pkgs.man-pages
      pkgs.openssh
      pkgs.pinentry-curses
      pkgs.ps
      pkgs.ripgrep
    ];

    imports = [
      ./fish
      ./git
      ./gpg
      ./tmux
    ];
  }