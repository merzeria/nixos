{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./localization.nix
    ./desktop.nix
    ./gaming.nix
    ./users.nix
    ./backup.nix
  ];

  # Core Nix Settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Global Nixpkgs Config
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
