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
    configFile.ksmserverrc.General.loginMode = "emptySession";
      configFile.kwinrc = {
      # The "Smoking Gun" fix from your diff
      "Effect-overview".BorderActivate = { value = 9; immutable = true; };

      # Keep the modern ones just in case of future updates
      "Effect-kwin4_effect_overview".BorderActivate = { value = 9; immutable = true; };
      "Effect-kwin4_effect_desktop_grid".BorderActivate = { value = 9; immutable = true; };
      "Effect-kwin4_effect_present_windows".BorderActivate = { value = 9; immutable = true; };

      # Exhaustive Touch/Screen Edge locks
      "org.kde.kwin.touchscreenedges".TopLeft = { value = 0; immutable = true; };
      "org.kde.kwin.screenedges".TopLeft = { value = 0; immutable = true; };
      "TouchEdges".TopLeft = { value = 0; immutable = true; };
      "TouchEdges".Top = { value = 0; immutable = true; };
      "ElectricBorders".TopLeft = { value = 0; immutable = true; };
      # Disable the resistance/stickiness between monitors
      "EdgeBarrier"."EdgeBarrier" = { value = 0; immutable = true; };
      "EdgeBarrier"."CornerBarrier" = { value = false; immutable = true; };

      # Master Kill Switch
      "ScreenEdges".Enabled = { value = false; immutable = true; };
      };
    # Add this section for Monitor Rules
    window-rules = [
      {
        description = "Move Vesktop to correct monitor";
        match = {
          window-class = "vesktop";
          };
        apply = {
          screen = 1;      # Try swapping this to 0 if 1 is wrong
          screenrule = 2;   # This forces the rule every time
        };
      }
      {
        description = "Move Steam to correct monitor";
        match = {
          window-class = "steam";
        };
        apply = {
          screen = 1;      # Try swapping this to 0 if 1 is wrong
          screenrule = 2;
        };
      }
    ];
    # Power Management and Screen Locking settings
    configFile.kscreenlockerrc.Daemon.Autolock = false;
    configFile.kscreenlockerrc.Daemon.LockOnResume = false;
    configFile.kscreenlockerrc.Daemon.Timeout = 0;
  };
}
