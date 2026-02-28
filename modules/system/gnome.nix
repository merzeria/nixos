{ pkgs, lib, ... }:

{
  services.desktopManager.plasma6.enable = lib.mkForce false;
  services.displayManager.sddm.enable    = lib.mkForce false;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable   = true;
  services.displayManager.gdm.wayland  = true;

  qt.platformTheme = lib.mkForce "gnome";
  qt.style         = lib.mkForce "adwaita-dark";

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-music
    epiphany
    geary
    totem
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    glib

    # Extensions
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.arcmenu
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection

    # Theme
    (fluent-gtk-theme.override {
      themeVariants = [ "purple" ];
      colorVariants  = [ "dark" ];
      sizeVariants   = [ "standard" ];
      tweaks         = [ "round" "float" ];
    })
    papirus-icon-theme
    catppuccin-cursors.mochaMauve
    nerd-fonts.jetbrains-mono
  ];

  # Required for AppIndicator (Steam, Discord tray icons)
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  home-manager.users.simon = {
    imports = [ ../home/gnome.nix ];
  };
}
