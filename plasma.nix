{ pkgs, themeName, isLaptop, lib, ... }:

{
  imports = [
    ./modules/themes/${themeName}.nix
  ];

  programs.plasma = {
    enable = true;
    overrideConfig = true;

    configFile = {
      "kwalletrc"."Wallet"."Enabled" = false;
      #"kwinrc"."Windows"."WindowMenuTimeout" = 5000;
      ksmserverrc.General.loginMode = "emptySession";
      "plasmanotifyrc"."Applications/org.kde.konsole"."ShowPopups" = false;
    };

    configFile.kwinrc = {
      "Effect-overview".BorderActivate                      = { value = 9; immutable = true; };
      "Effect-kwin4_effect_overview".BorderActivate         = { value = 9; immutable = true; };
      "Effect-kwin4_effect_desktop_grid".BorderActivate     = { value = 9; immutable = true; };
      "Effect-kwin4_effect_present_windows".BorderActivate  = { value = 9; immutable = true; };
      "org.kde.kwin.touchscreenedges".TopLeft               = { value = 0; immutable = true; };
      "org.kde.kwin.screenedges".TopLeft                    = { value = 0; immutable = true; };
      "TouchEdges".TopLeft                                  = { value = 0; immutable = true; };
      "TouchEdges".Top                                      = { value = 0; immutable = true; };
      "ElectricBorders".TopLeft                             = { value = 0; immutable = true; };
      "EdgeBarrier"."EdgeBarrier"                           = { value = 0;     immutable = true; };
      "EdgeBarrier"."CornerBarrier"                         = { value = false; immutable = true; };
      "ScreenEdges".Enabled                                 = { value = false; immutable = true; };
    };

    configFile.kscreenlockerrc.Daemon.Autolock    = false;
    configFile.kscreenlockerrc.Daemon.LockOnResume = false;
    configFile.kscreenlockerrc.Daemon.Timeout     = 0;

    window-rules = lib.optionals (!isLaptop) [
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
