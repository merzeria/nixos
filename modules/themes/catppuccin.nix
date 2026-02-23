{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      #lookAndFeel = "Catppuccin";
      colorScheme = "CatppuccinMochaMauve";
      cursor.theme = "catppuccin-mocha-Mauve-cursors";
      iconTheme = "Papirus-Dark";
      wallpaper = "${pkgs.nixos-artwork.wallpapers.catppuccin-mocha}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-mocha.png";
      windowDecorations.library = "org.kde.kwin.aurorae";
      # Aurorae themes usually follow this hyphenated pattern
      windowDecorations.theme = "__aurorae__svg__CatppuccinMocha-Classic";
      splashScreen.theme = "Catppuccin-Mocha-Mauve";
    };

    # catppuccin supports Kvantum but can also use the standard style
    configFile = {
    "kdeglobals"."General"."widgetStyle" = "kvantum";
    "kvantumrc"."General"."theme" = "catppuccin-mocha-mauve";
  };
    panels = [
      {
        location = "bottom";
        height = 36;
        screen = 0; # Main monitor
        widgets = [
          { name = "org.kde.plasma.kickoff"; config.General.icon = ./icons/nix.svg; }
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
      { name = "org.kde.plasma.kickoff"; config.General.icon = ./icons/nix.svg; }
      "org.kde.plasma.icontasks"
      "org.kde.plasma.marginsseparator"
      "org.kde.plasma.systemtray"
      "org.kde.plasma.digitalclock"
      ];
    }
  ];
};

  home.packages = with pkgs; [
    #catppuccin-kde        # Provides the Global Theme
    catppuccin-cursors# Provides the Cursors
    catppuccin-cursors.mochaMauve
    nixos-artwork.wallpapers.catppuccin-mocha
  ];
}
