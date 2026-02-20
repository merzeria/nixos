{ config, pkgs, ... }:

{
  # Example: set Breeze Dark as the global theme
  programs.plasma.theme = "BreezeDark";

  # Enable the default set of KDE applications
  environment.systemPackages = with pkgs; [
    plasma-browser-integration
    dolphin
    konsole
    kate
  ];
}