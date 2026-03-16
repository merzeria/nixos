{ inputs, pkgs, themeName, ... }:

{
  imports = [
  inputs.plasma-manager.homeModules.plasma-manager
    ../common
    ./desktop.nix
    ./niri
    ../../../plasma.nix
  ];
}
