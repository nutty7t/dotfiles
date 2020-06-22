{ pkgs ? import <nixpkgs> {} }:
  pkgs.stdenv.mkDerivation {
    name = "dotfiles";
    src = [ ./. ];
    installPhase = ''
      # Clone repo into derivation
      mkdir --parents $out/share/dotfiles
      cp --recursive $src/* $out/share/dotfiles

      # Symlink all *.symlink files to $out/share
      # E.g. $src/foo/bar.symlink -> $out/.bar
      symlink_command='ln --force --symbolic {} $out/share/dotfiles/.$(basename {} .symlink)'
      find $src -name '*.symlink' | xargs --replace={} --max-args=1 bash -c "''${symlink_command}"
    '';
  }
