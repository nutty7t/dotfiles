{ config, pkgs, ... }:
  let
    doom-emacs = pkgs.callPackage (builtins.fetchTarball {
      url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
    }) {
      doomPrivateDir = ./doom.d;
    };
  in
    {
      home.file.".emacs.d/init.el".text = ''
        (load "default.el")
      '';

      home.packages = [
        doom-emacs
        pkgs.iosevka
        pkgs.emacs-all-the-icons-fonts
        pkgs.material-design-icons
        pkgs.weather-icons
        pkgs.font-awesome
      ];
    }
