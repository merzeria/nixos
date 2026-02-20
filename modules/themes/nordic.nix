# modules/themes/nordic.nix
{ pkgs, ... }:

{
  plasma-manager = {
    user = "simon";

    # -------------------- Desktop theme --------------------
    theme = {
      name = "Nordic";
      # The Nordik theme lives in the `kdePackages` collection
      package = pkgs.kdePackages.plasma5-themes.nordic;

      # -------------------- Colour scheme --------------------
      # Nordik ships its own colour scheme named "Nordic"
      colorScheme = {
        name = "Nordic";
        # If you ever want a custom .colors file you can add:
        # path = /path/to/custom.colors;
      };

      # -------------------- Icon theme --------------------
      icons = {
        name = "Papirus-Dark";               # matches the dark aesthetic
        package = pkgs.kdePackages.papirus-icon-theme;
      };

      # -------------------- Cursor theme --------------------
      cursor = {
        name = "Breeze Snow";
        package = pkgs.kdePackages.breeze-cursor-theme;
      };
    };

    # -------------------- Window decorations --------------------
    kwin.decoration = {
      name = "Nordic";
      package = pkgs.kdePackages.plasma5-themes.nordic;
    };

    # -------------------- Splash screen --------------------
    splash = {
      name = "Nordic";
      package = pkgs.kdePackages.plasma5-themes.nordic;
    };

    # -------------------- Lock screen --------------------
    lockScreen = {
      theme = {
        name = "Nordic";
        package = pkgs.kdePackages.plasma5-themes.nordic;
      };
    };

    # -------------------- Visual effects (optional) --------------------
    kwin.effects = {
      blur = true;
      roundedCorners = true;
    };

    # -------------------- Panel (taskbar) example --------------------
    panels = [
      {
        location = "bottom";
        height = 38;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.appmenu"
        ];
      }
    ];
  };
}