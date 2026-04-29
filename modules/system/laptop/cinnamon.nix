{ pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  # Or keep using SDDM if you prefer:
  # services.displayManager.sddm.enable = true;

  services.cinnamon.apps.enable = true;  # Cinnamon's default apps (nemo, etc.)

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    # Cinnamon-specific extras you might want
    cinnamon-common
  ];

  # Disable KDE-specific stuff if this is loaded instead of kde.nix
  services.gnome.gnome-keyring.enable = true;  # Cinnamon uses this
}
