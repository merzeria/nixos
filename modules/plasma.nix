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
      # 1. Classic Electric Borders (Standard Hot Corners)
      ElectricBorders.TopLeft = 0;
      ElectricBorders.TopRight = 0;
      ElectricBorders.BottomLeft = 0;
      ElectricBorders.BottomRight = 0;

      # 2. Modern Touch/Screen Edges
      TouchEdges.Top = 0;
      TouchEdges.Bottom = 0;
      TouchEdges.Left = 0;
      TouchEdges.Right = 0;

      # 3. Disable the Trigger Plugins (Crucial for Plasma 6)
      Plugins = {
        screenedge_overviewEnabled = {
          value =false;
          immutable = true;
        };
        screenedge_desktopgridEnabled = false;
        screenedge_presentwindowsEnabled = false;
        kwin4_effect_overviewEnabled = false;
      };

      # 4. Remove the Desktop Effect triggers
      "Effect-Overview".BorderActivate = 9;
      "Effect-DesktopGrid".BorderActivate = 9;
      "Effect-PresentWindows".BorderActivate = 9;

      # 5. Barrier Fix (No more "sticky" mouse)
      EdgeBarrier.EdgeBarrier = 0;
      EdgeBarrier.CornerBarrier = false;

      # This is the "God Mode" fix for the top-left corner in Plasma 6
      "Effect-kwin4_effect_overview".BorderActivate = {
        value = 9;
        immutable = true;
        };
      "Effect-kwin4_effect_present_windows".BorderActivate = 9;

      # Disable the "Screen Edge" gesture system
      ScreenEdges.Enabled = false;

      # Force-kill any lingering touch-based edge triggers
      "org.kde.kwin.screenedges".TopLeft = 0;
      "org.kde.kwin.touchscreenedges".TopLeft = 0;
    };
  };
}

