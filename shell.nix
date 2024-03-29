# https://nixos.wiki/wiki/Flakes#Super_fast_nix-shell
{ pkgs ? import <nixpkgs> { } }:
with pkgs;
mkShell {
  buildInputs = [
    pkgs.gnumake
    pkgs.google-cloud-sdk
    pkgs.hugo
    pkgs.wget
  ];
}
