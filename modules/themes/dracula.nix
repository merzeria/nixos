{ pkgs, lib, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      cursor.theme = "Dracula-cursors";
      iconTheme = "Dracula";
      colorScheme = "Dracula";
      wallpaper = "${pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath}";
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Dracula";
      splashScreen.theme = "Dracula";
    };
    configFile = {
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "konsolerc"."Desktop Entry"."DefaultProfile" = "simon.profile";
    };
    panels = [
      {
        location = "bottom";
        height = 36;
        screen = 0;
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
        screen = 1;
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

  xdg.dataFile."konsole/Dracula.colorscheme" = {
    force = true;
    text = ''
      [General]
      Description=Dracula
      Opacity=0.9
      Wallpaper=

      [Background]
      Color=#282a36
      [BackgroundIntense]
      Color=#282a36

      [Foreground]
      Color=#f8f8f2
      [ForegroundIntense]
      Color=#ffffff

      [Color0]
      Color=#21222c
      [Color0Intense]
      Color=#6272a4

      [Color1]
      Color=#ff5555
      [Color1Intense]
      Color=#ff6e6e

      [Color2]
      Color=#50fa7b
      [Color2Intense]
      Color=#69ff94

      [Color3]
      Color=#f1fa8c
      [Color3Intense]
      Color=#ffffa5

      [Color4]
      Color=#bd93f9
      [Color4Intense]
      Color=#d6acff

      [Color5]
      Color=#ff79c6
      [Color5Intense]
      Color=#ff92df

      [Color6]
      Color=#8be9fd
      [Color6Intense]
      Color=#a4ffff

      [Color7]
      Color=#f8f8f2
      [Color7Intense]
      Color=#ffffff
    '';
  };

  home.activation.konsoleProfile = lib.hm.dag.entryAfter ["writeBoundary"] ''
    printf '[Appearance]\nColorScheme=Dracula\nFont=JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0\n\n[General]\nName=simon\nParent=FALLBACK/\n' \
      > "$HOME/.local/share/konsole/simon.profile"
  '';

  home.packages = with pkgs; [
    dracula-theme
    dracula-icon-theme
    nixos-artwork.wallpapers.dracula
  ];
}
