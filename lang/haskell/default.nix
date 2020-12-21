{ config, pkgs, ... }:
  {
    home.packages = [
      pkgs.haskellPackages.hlint
      pkgs.haskellPackages.hoogle
      pkgs.haskellPackages.ormolu
    ];

    home.file = {
      ".ghci".text = ''
        :set prompt "λ> "
      '';
    };
  }
