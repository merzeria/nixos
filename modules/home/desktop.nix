{ ... }:

{
  # Konsole Catppuccin Colorscheme
  xdg.dataFile."konsole/CatppuccinMocha.colorscheme" = {
  force = true;
  text = ''

  [General]
  Description=Catppuccin Mocha
  Opacity=0.9
  Wallpaper=

  [Background]
  Color=#1e1e2e
  [BackgroundIntense]
  Color=#1e1e2e

  [Foreground]
  Color=#cdd6f4
  [ForegroundIntense]
  Color=#cdd6f4

  # Black (Surface 1 / Surface 2)
  [Color0]
  Color=#45475a
  [Color0Intense]
  Color=#585b70

  # Red
  [Color1]
  Color=#f38ba8
  [Color1Intense]
  Color=#f38ba8

  # Green
  [Color2]
  Color=#a6e3a1
  [Color2Intense]
  Color=#a6e3a1

  # Yellow
  [Color3]
  Color=#f9e2af
  [Color3Intense]
  Color=#f9e2af

  # Blue
  [Color4]
  Color=#89b4fa
  [Color4Intense]
  Color=#89b4fa

  # Magenta (Mauve)
  [Color5]
  Color=#cba6f7
  [Color5Intense]
  Color=#cba6f7

  # Cyan (Teal)
  [Color6]
  Color=#94e2d5
  [Color6Intense]
  Color=#94e2d5

  # White (Subtext 1 / Subtext 0)
  [Color7]
  Color=#bac2de
  [Color7Intense]
  Color=#a6adc8
  '';
  };

  # Delayed Autostart
  xdg.configFile = {
    "autostart/steam.desktop".text = ''
      [Desktop Entry]
      Name=Steam
      Exec=sh -c "sleep 10 && steam -silent %U"
      Type=Application
    '';
    "autostart/equibop.desktop".text = ''
      [Desktop Entry]
      Name=equibop (Delayed)
      Exec=sh -c "sleep 10 && equibop"
      Type=Application
    '';
  };
}
