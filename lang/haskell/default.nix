{ config, pkgs, ... }:
  {
    home.packages = [
      pkgs.haskellPackages.cabal-install
      pkgs.haskellPackages.ghc
      pkgs.haskellPackages.hlint
      pkgs.haskellPackages.hoogle
      pkgs.haskellPackages.ormolu
      pkgs.haskellPackages.stack
    ];

    home.file = {
      ".ghci".text = ''
        :set prompt "λ> "
      '';
    };
  }
