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
      #lookAndFeel = "com.github.vinceliuice.Nordic";
      cursor.theme = "Nordzy-cursors";
      iconTheme = "Nordzy-purple-dark";
      colorScheme = "Nordic";
      wallpaper = ./wallpapers/nordic.jpg;
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Nordic";
      splashScreen.theme = "Nordic";
    };

    # Enable blur and Kvantum for the Nordic aesthetic
    configFile."kwinrc"."Plugins".blurEnabled = true;
    configFile."kdeglobals"."General"."widgetStyle" = "kvantum";

    panels = [
      {
        location = "bottom";
        height = 36;
        screen = 0;
        widgets = myWidgets;
      }
      {
        location = "bottom";
        height = 36;
        screen = 1;
        widgets = myWidgets;
      }
    ];
  };

  home.packages = with pkgs; [
    nordic
    nordzy-cursor-theme
    nordzy-icon-theme
  ];
}
