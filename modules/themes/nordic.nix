{ pkgs, ... }:

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
      cursor.theme = "Nordzy-cursors";
      iconTheme = "Nordzy-purple-dark";
      colorScheme = "Nordic";
      wallpaper = ./wallpapers/nordic.jpg;
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Nordic";
      splashScreen.theme = "Nordic";
    };

    configFile = {
      "kwinrc"."Plugins".blurEnabled = true;
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "konsolerc"."Desktop Entry"."DefaultProfile" = "Nordic.profile";
    };

    panels = [
      { location = "bottom"; height = 36; screen = 0; widgets = myWidgets; }
      { location = "bottom"; height = 36; screen = 1; widgets = myWidgets; }
    ];
  };

  xdg.configFile."konsole/Nordic.colorscheme".text = ''
    [General]
    Description=Nordic
    Opacity=0.9
    Wallpaper=

    [Background]
    Color=#2e3440
    [BackgroundIntense]
    Color=#3b4252

    [Foreground]
    Color=#d8dee9
    [ForegroundIntense]
    Color=#eceff4

    [Color0]
    Color=#3b4252
    [Color0Intense]
    Color=#4c566a

    [Color1]
    Color=#bf616a
    [Color1Intense]
    Color=#bf616a

    [Color2]
    Color=#a3be8c
    [Color2Intense]
    Color=#a3be8c

    [Color3]
    Color=#ebcb8b
    [Color3Intense]
    Color=#ebcb8b

    [Color4]
    Color=#81a1c1
    [Color4Intense]
    Color=#81a1c1

    [Color5]
    Color=#b48ead
    [Color5Intense]
    Color=#b48ead

    [Color6]
    Color=#88c0d0
    [Color6Intense]
    Color=#8fbcbb

    [Color7]
    Color=#e5e9f0
    [Color7Intense]
    Color=#eceff4
  '';

  xdg.configFile."konsole/Nordic.profile".text = ''
    [Appearance]
    ColorScheme=Nordic
    Font=JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0

    [General]
    Name=Nordic
    Parent=FALLBACK/
  '';

  home.packages = with pkgs; [
    nordic
    nordzy-cursor-theme
    nordzy-icon-theme
  ];
}
