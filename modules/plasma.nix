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

    # Add this section for Monitor Rules
    window-rules = [
      {
        description = "Move Vesktop to second monitor";
        match = {
          window-class = { value = "vesktop"; type = "exact"; };
        };
        apply = {
          screen = 0; # Usually the second monitor
        };
      }
      {
        description = "Move Steam to second monitor";
        match = {
          window-class = { value = "steam"; type = "exact"; };
        };
        apply = {
          screen = 0;
        };
      }
    ];
  };
}
