{ inputs, pkgs, themeName, isGnome ? false, ... }:

{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./desktop.nix
  ] ++ (if !isGnome then [ (import ../plasma.nix { inherit pkgs themeName; }) ] else []);

  home.username = "simon";
  home.homeDirectory = "/home/simon";
  home.stateVersion = "25.11";
}
