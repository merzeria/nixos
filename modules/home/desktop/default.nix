{ inputs, pkgs, themeName, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ../common
    ./packages.nix
    ./desktop.nix
    # plasma.nix at repo root — receives themeName via extraSpecialArgs
    ../../../plasma.nix
  ];
}
