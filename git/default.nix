{ config, pkgs, ... }:
  {
    programs.git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;

      userName = "nutty7t";
      userEmail = "blackhole@nutty.email";

      signing = {
        key = "2A23A66A";
        signByDefault = true;
      };

      extraConfig = {
        core.editor = "nvim -i NONE";
      };

      delta = {
        enable = true;
      };
    };
  }