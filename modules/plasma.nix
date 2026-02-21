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
        description = "Move Vesktop to correct monitor";
        match = {
          window-class = { value = "vesktop"; type = "exact"; };
        };
        apply = {
          screen = 1;      # Try swapping this to 0 if 1 is wrong
          screenrule = 2;   # This forces the rule every time
        };
      }
      {
        description = "Move Steam to correct monitor";
        match = {
          window-class = { value = "steam"; type = "exact"; };
        };
        apply = {
          screen = 1;      # Try swapping this to 0 if 1 is wrong
          screenrule = 2;
        };
      }
    ];
   # This manually writes to the kwinrc file to kill the corners
    configFile.kwinrc = {
      ElectricBorders.TopLeft = 0;
      ElectricBorders.TopRight = 0;
      ElectricBorders.BottomLeft = 0;
      ElectricBorders.BottomRight = 0;
      ElectricBorders.Top = 0;
      ElectricBorders.Bottom = 0;
      ElectricBorders.Left = 0;
      ElectricBorders.Right = 0;

      # This kills that tiny "resistance" when moving the mouse between monitors
      EdgeBarrier.EdgeBarrier = 0;
    };
};
}

