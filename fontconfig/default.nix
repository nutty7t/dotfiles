{ config, pkgs, ... }:
  {
    fonts.fontconfig = {
      enable = true;
    };

    home.sessionVariables = {
      FONTCONFIG_FILE = "$HOME/.config/fontconfig/conf.d/10-hm-fonts.conf";
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    };
  }
