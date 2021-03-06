{ config, pkgs, ... }:
  {
    programs.gpg = {
      enable = true;
    };

    programs.ssh = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      enableScDaemon = false;
      pinentryFlavor = "emacs";
      extraConfig = ''
        # fallback to curses if emacs pinentry is not available
        pinentry-program ${pkgs.pinentry-curses}/bin/pinentry

        allow-emacs-pinentry
        allow-loopback-pinentry
      '';
    };
  }
