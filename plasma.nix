# Root plasma.nix — proper NixOS/HM module, receives themeName via extraSpecialArgs
{ pkgs, themeName, ... }:

{
  imports = [
    # Dynamically loads ./themes/sweet.nix, ./themes/nordic.nix etc.
    ./modules//themes/${themeName}.nix
  ];

  # Common Plasma settings applied to ALL themes
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    configFile = {
      # Disable KDE Wallet
      "kwalletrc"."Wallet"."Enabled" = false;
      # Prevent plasma crash on startup
      "kwinrc"."Windows"."WindowMenuTimeout" = 5000;
      # Session restore
      ksmserverrc.General.loginMode = "emptySession";
    };

    configFile.kwinrc = {
      # Disable all screen edge / hot corner triggers
      "Effect-overview".BorderActivate                          = { value = 9; immutable = true; };
      "Effect-kwin4_effect_overview".BorderActivate             = { value = 9; immutable = true; };
      "Effect-kwin4_effect_desktop_grid".BorderActivate         = { value = 9; immutable = true; };
      "Effect-kwin4_effect_present_windows".BorderActivate      = { value = 9; immutable = true; };
      "org.kde.kwin.touchscreenedges".TopLeft                   = { value = 0; immutable = true; };
      "org.kde.kwin.screenedges".TopLeft                        = { value = 0; immutable = true; };
      "TouchEdges".TopLeft                                      = { value = 0; immutable = true; };
      "TouchEdges".Top                                          = { value = 0; immutable = true; };
      "ElectricBorders".TopLeft                                 = { value = 0; immutable = true; };
      # Disable monitor edge resistance
      "EdgeBarrier"."EdgeBarrier"                               = { value = 0;     immutable = true; };
      "EdgeBarrier"."CornerBarrier"                             = { value = false; immutable = true; };
      # Master kill switch
      "ScreenEdges".Enabled                                     = { value = false; immutable = true; };
    };

    # Screen lock — disabled
    configFile.kscreenlockerrc.Daemon.Autolock    = false;
    configFile.kscreenlockerrc.Daemon.LockOnResume = false;
    configFile.kscreenlockerrc.Daemon.Timeout     = 0;

    # Window rules
    window-rules = [
      {
        description = "Force Discord clients to second monitor";
        match.window-class = { value = "equibop"; type = "regex"; };
        apply = { screen = 1; screenrule = 2; };
      }
      {
        description = "Move Steam to correct monitor";
        match.window-class = "steam";
        apply = { screen = 1; screenrule = 2; };
      }
    ];
  };
}
