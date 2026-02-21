{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      #lookAndFeel = "Dracula";
      cursor.theme = "Dracula-cursors";
      iconTheme = "Dracula";
      colorScheme = "Dracula";
      wallpaper = "${pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath}";
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Dracula";
      splashScreen.theme = "Dracula";

    };

    # Dracula supports Kvantum but can also use the standard style
    configFile."kdeglobals"."General"."widgetStyle" = "kvantum";

    panels = [
      {
        location = "bottom";
        height = 36;
        screen = 0; # Main monitor
        widgets = [
          { name = "org.kde.plasma.kickoff"; config.General.icon = "nix-snowflake-white"; }
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
  {
    location = "bottom";
    height = 36;
    screen = 1; # Second monitor
    widgets = [
      { name = "org.kde.plasma.kickoff"; config.General.icon = "nix-snowflake-white"; }
      "org.kde.plasma.icontasks"
      "org.kde.plasma.marginsseparator"
      "org.kde.plasma.systemtray"
      "org.kde.plasma.digitalclock"
      ];
    }
  ];
};

  home.packages = with pkgs; [
    dracula-theme        # Provides the Global Theme
    dracula-icon-theme   # Provides the Icons
    nixos-artwork.wallpapers.dracula
  ];
}
