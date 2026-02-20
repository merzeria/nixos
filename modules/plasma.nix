# modules/plasma.nix
{ config, pkgs, themeName, ... }:

{
  imports = [
    # Pull in the concrete theme module based on the selector
    (import ./themes/${themeName}.nix { inherit pkgs; })
  ];
}