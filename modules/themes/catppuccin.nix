{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      colorScheme = "CatppuccinMochaMauve";
      cursor.theme = "catppuccin-mocha-Mauve-cursors";
      iconTheme = "Papirus-Dark";
      wallpaper = "${pkgs.nixos-artwork.wallpapers.catppuccin-mocha}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-mocha.png";
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__CatppuccinMocha-Classic";
      splashScreen.theme = "Catppuccin-Mocha-Mauve";
    };

    configFile = {
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "kvantumrc"."General"."theme" = "catppuccin-mocha-mauve";
    };

    panels = [
      {
        location = "bottom";
        height = 36;
        screen = 0;
        widgets = [
          { name = "org.kde.plasma.kickoff"; config.General.icon = "${./icons/nix.svg}"; }
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
      {
        location = "bottom";
        height = 36;
        screen = 1;
        widgets = [
          { name = "org.kde.plasma.kickoff"; config.General.icon = "${./icons/nix.svg}"; }
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };

  home.packages = with pkgs; [
    catppuccin-cursors.mochaMauve
    nixos-artwork.wallpapers.catppuccin-mocha
  ];
}
