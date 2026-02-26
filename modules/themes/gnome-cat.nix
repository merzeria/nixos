{ pkgs, ... }:

{
  # SYSTEM LEVEL: Global packages for GNOME
  environment.systemPackages = with pkgs; [
    catppuccin-gtk
    papirus-icon-theme
    nerd-fonts.jetbrains-mono
    catppuccin-cursors.mochaMauve
  ];

  # USER LEVEL: Home Manager settings
  home-manager.users.simon = {
    dconf.enable = true;

    # 1. Pointer Cursor belongs directly under the user block
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "catppuccin-mocha-mauve-cursors"; 
      package = pkgs.catppuccin-cursors.mochaMauve; 
      size = 24;
    };

    # 2. GTK theme settings are separate
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
    }; # This bracket closes the GTK block

    dconf.settings = {
      "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer" ];
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-theme = "catppuccin-mocha-mauve-standard";
        font-name = "Ubuntu 11";
        document-font-name = "Ubuntu 11";
        monospace-font-name = "JetBrainsMono Nerd Font 10";
        icon-theme = "Papirus-Dark";
      };
      "org/gnome/Console" = {
        font-name = "JetBrainsMono Nerd Font 12";
        use-system-font = false;
      };
    };
  };
}
