{ pkgs, ... }:

{
  dconf.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Ubuntu";
      size = 11;
    };
  };

  dconf.settings = {
    "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "catppuccin-mocha-mauve-standard";
      font-name = "Ubuntu 11";
      document-font-name = "Ubuntu 11";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
      icon-theme = "Papirus-Dark";
      cursor-theme = "catppuccin-mocha-mauve-cursors";
      cursor-size = 24;
    };

    "org/gnome/Console" = {
      font-name = "JetBrainsMono Nerd Font 12";
      use-system-font = false;
    };

    # Disable hot corners
    "org/gnome/desktop/interface".enable-hot-corners = false;
  };
}
