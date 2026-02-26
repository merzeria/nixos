{ pkgs, ... }:

{
  # System-wide packages for this theme
  environment.systemPackages = with pkgs; [
    catppuccin-gtk
    papirus-icon-theme
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  home-manager.users.simonos = {
    # Set the cursor/icon/font settings specifically for GNOME
    dconf.settings = {
      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
        };
      "org/gnome/desktop/interface" = {
        font-name = "Ubuntu 11";
        document-font-name = "Ubuntu 11";
        monospace-font-name = "JetBrainsMono Nerd Font 10";
        icon-theme = "Papirus-Dark";
      };
    };

    # Set up the terminal (GNOME Console/KGX) to use the new font
    programs.gnome-console = {
      enable = true;
      font = "JetBrainsMono Nerd Font 12";
    };
  };
}
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
simonos/modules/themes/gnome-cat.nix [+]                                                                                                                                         1,1            All

