{ pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  services.displayManager.sddm = {
    enable         = true;
    wayland.enable = true;
  };
  services.displayManager.autoLogin = {
    enable = true;
    user   = "simon";
  };

  services.cinnamon.apps.enable = true;
  services.flatpak.enable = true;

  # Cinnamon uses gnome-keyring
  services.gnome.gnome-keyring.enable = true;
}
