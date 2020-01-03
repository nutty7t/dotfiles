{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.docker
    pkgs.fselect
    pkgs.shellcheck
  ];
}
