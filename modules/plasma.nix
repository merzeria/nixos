# modules/plasma.nix
{ pkgs, themeName, ... }:

{
  imports = [
    # This dynamically loads ./themes/sweet.nix or ./themes/nordic.nix
    ./themes/${themeName}.nix
  ];

  # You can put common Plasma settings here that apply to ALL themes
  programs.plasma = {
    enable = true;
    overrideConfig = true; # Ensures Nix config wins over manual GUI changes
  };
}
