{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    catppuccin-gtk
    papirus-icon-theme
    # NEW: Individual font package name
    nerd-fonts.jetbrains-mono
  ];

  home-manager.users.simon = {
    dconf.enable = true;

    # Consolodated GTK settings from desktop.nix
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
    };

    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
      };

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
