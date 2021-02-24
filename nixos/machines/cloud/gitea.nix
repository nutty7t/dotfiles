{ config, lib, pkgs, ... }:

let
  giteaConfig = config.services.gitea;
in
  {
    users.groups.git = { };
    users.users.git = {
      description = "Gitea Service";
      group = "git";
      home = giteaConfig.stateDir;
      isSystemUser = true;
      useDefaultShell = true;
    };

    services.gitea = {
      enable = true;
      appName = "Nutty Code";
      disableRegistration = true;
      cookieSecure = true;
      database = {
        type = "postgres";
        user = "git";
        name = "gitea";
        passwordFile = "/run/secrets/gitea-database-password";
        createDatabase = true;
      };
      domain = "code.nutty.services";
      rootUrl = "https://${giteaConfig.domain}/";
      httpAddress = "127.0.0.1";
      httpPort = 44832;
      log.level = "Error";
      settings = {
        other.SHOW_FOOTER_VERSION = false;
      };
      stateDir = "/app/gitea";
      user = "git";
    };

    services.nginx.virtualHosts."code.nutty.services" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:${toString giteaConfig.httpPort}";
        proxyWebsockets = true;
      };
    };

    services.secrets.gitea = {
      secretFile = ./secrets/gitea-database-password;
      mountPath = "/run/secrets/gitea-database-password";
      owner = "git";
      group = "git";
    };
  }
