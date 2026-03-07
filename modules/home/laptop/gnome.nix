{ pkgs, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name       = "catppuccin-mocha-mauve-cursors";
    package    = pkgs.catppuccin-cursors.mochaMauve;
    size       = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name    = "Colloid-Pink-Dark";
      package = pkgs.colloid-gtk-theme.override {
        themeVariants = [ "pink" ];
        colorVariants  = [ "dark" ];
        tweaks         = [ "rimless" "black" ];
      };
    };
    iconTheme = {
      name    = "Colloid-Dark";
      package = pkgs.colloid-icon-theme;
    };
    font = {
      name = "Noto Sans";
      size = 11;
    };
  };
}
