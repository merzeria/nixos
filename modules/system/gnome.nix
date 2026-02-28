{ pkgs, lib, ... }:

{
  # Enable GNOME and GDM, disable KDE/SDDM from the base config
  services.desktopManager.plasma6.enable = lib.mkForce false;
  services.displayManager.sddm.enable    = lib.mkForce false;

  services.desktopManager.gnome.enable  = true;
  services.displayManager.gdm.enable    = true;
  services.displayManager.gdm.wayland   = true;

  # Use GTK theming instead of KDE's Qt layer
  qt.platformTheme = lib.mkForce "gnome";
  qt.style         = lib.mkForce "adwaita-dark";

  # Remove some GNOME bloat
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-music
    epiphany
    geary
    totem
  ];

  # System packages needed for GNOME theming and tooling
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    glib
    (catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; })
    papirus-icon-theme
    nerd-fonts.jetbrains-mono
    catppuccin-cursors.mochaMauve
  ];

  # Pull in the Home Manager GNOME config for simon
  home-manager.users.simon = {
    imports = [ ../home/gnome.nix ];
  };
}
