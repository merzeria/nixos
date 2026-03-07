{ inputs, pkgs, themeName, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./desktop.nix
    (import ../plasma.nix { inherit pkgs themeName; })
  ];

  home.username = "simon";
  home.homeDirectory = "/home/simon";
  home.stateVersion = "25.11";
}
