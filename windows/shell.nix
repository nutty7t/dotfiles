{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.fselect
    pkgs.nodejs
    pkgs.shellcheck
  ];
}
