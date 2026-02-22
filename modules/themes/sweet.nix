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
      #lookAndFeel = "com.github.vinceliuice.Sweet";
      cursor.theme = "Sweet-cursors";
      iconTheme = "candy-icons";
      colorScheme = "Sweet";
      wallpaper = ./wallpapers/abstract.png;
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Sweet-Dark-transparent";
      splashScreen.theme = "Sweet";

    };

    # Force Kvantum for the "Glassy" look
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
    sweet-nova
    candy-icons
  ];
}
