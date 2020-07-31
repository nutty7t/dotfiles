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
      pkgs.coreutils
      pkgs.docker
      pkgs.doctl
      pkgs.emacs
      pkgs.exa
      pkgs.fd
      pkgs.fontconfig
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

      pkgs.iosevka
      pkgs.emacs-all-the-icons-fonts
      pkgs.material-design-icons
      pkgs.weather-icons
      pkgs.font-awesome
    ];

    imports = [
      ./emacs
      ./fish
      ./fontconfig
      ./git
      ./gpg
      ./tmux
    ];
  }
