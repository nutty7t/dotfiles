{ config, pkgs, ... }:
  {
    home.file.".doom.d/init.el".text = builtins.readFile ./doom.d/init.el;
    home.file.".doom.d/config.el".text = builtins.readFile ./doom.d/config.el;
    home.file.".doom.d/packages.el".text = builtins.readFile ./doom.d/packages.el;

    home.packages = [
      pkgs.iosevka
      pkgs.emacs-all-the-icons-fonts
      pkgs.material-design-icons
      pkgs.weather-icons
      pkgs.font-awesome
    ];
  }
