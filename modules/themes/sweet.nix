{ pkgs, lib, ... }:

let
  myWidgets = [
    "org.kde.plasma.kickoff"
    "org.kde.plasma.icontasks"
    "org.kde.plasma.marginsseparator"
    "org.kde.plasma.systemtray"
    "org.kde.plasma.digitalclock"
  ];
in
{
  programs.plasma = {
    enable = true;
    workspace = {
      cursor.theme = "Sweet-cursors";
      iconTheme = "candy-icons";
      colorScheme = "Sweet";
      wallpaper = ./wallpapers/abstract.png;
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Sweet-Dark-transparent";
      splashScreen.theme = "Sweet";
    };
    configFile = {
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "kvantumrc"."General"."theme" = "Sweet-transparent-toolbar";
      "konsolerc"."Desktop Entry"."DefaultProfile" = "simon.profile";
    };
    panels = [
      { location = "bottom"; height = 36; screen = 0; widgets = myWidgets; }
      { location = "bottom"; height = 36; screen = 1; widgets = myWidgets; }
    ];
  };

  xdg.dataFile."konsole/Sweet.colorscheme" = {
    force = true;
    text = ''
      [General]
      Description=Sweet
      Opacity=0.85
      Wallpaper=

      [Background]
      Color=#1e1d2f
      [BackgroundIntense]
      Color=#2a2a3d

      [Foreground]
      Color=#e0def4
      [ForegroundIntense]
      Color=#ffffff

      [Color0]
      Color=#1e1d2f
      [Color0Intense]
      Color=#3b3a52

      [Color1]
      Color=#f05e97
      [Color1Intense]
      Color=#f07da8

      [Color2]
      Color=#5eff6c
      [Color2Intense]
      Color=#80ff8c

      [Color3]
      Color=#f3c173
      [Color3Intense]
      Color=#f5ce8e

      [Color4]
      Color=#7e9ef5
      [Color4Intense]
      Color=#9ab0f5

      [Color5]
      Color=#b072d1
      [Color5Intense]
      Color=#c084e0

      [Color6]
      Color=#70e6d0
      [Color6Intense]
      Color=#8aeedd

      [Color7]
      Color=#e0def4
      [Color7Intense]
      Color=#ffffff
    '';
  };

  home.activation.konsoleProfile = lib.hm.dag.entryAfter ["writeBoundary"] ''
    printf '[Appearance]\nColorScheme=Sweet\nFont=JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0\n\n[General]\nName=simon\nParent=FALLBACK/\n' \
      > "$HOME/.local/share/konsole/simon.profile"
  '';

  home.packages = with pkgs; [
    sweet-nova
    candy-icons
  ];
}
