{ inputs, pkgs, themeName, ... }:

{
  imports = [
    # Pull in the Plasma-Manager module from flake inputs
    inputs.plasma-manager.homeModules.plasma-manager
    # Specialized modules
    ./packages.nix
    ./shell.nix
    ./git.nix
    ./desktop.nix
 ] ++ (if (themeName != "gnome-cat") then [(import ../plasma.nix { inherit pkgs themeName; })] else []);

  home.username = "simon";
  home.homeDirectory = "/home/simon";
  home.stateVersion = "25.11";
}
