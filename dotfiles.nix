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

      # The $HOME variable is set to the path of this derivation in the wrapped
      # git derivation. When neovim starts up, it attempts to create the
      # following directory if it does not already exist, but throws an error
      # because the nix store is read-only. Whenever I get around to migrating
      # these dotfiles into home manager, I'll fix this.
      mkdir --parents $out/share/dotfiles/.local/share/nvim
    '';
  }
