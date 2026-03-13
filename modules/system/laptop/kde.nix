{ pkgs, lib, ... }:
{
  services.xserver.enable              = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable              = true;

 #services.displayManager.sddm = {
    #enable         = true;
    #wayland.enable = true;
   # theme          = "catppuccin-sddm-corners";
  #};
  services.displayManager.plasma-login-manager = {
    enable = true;
  };

  environment.etc."sddm/themes/catppuccin-sddm-corners/theme.conf.user".text = ''
    [General]
    Flavor=mocha
    Accent=mauve
  '';

  qt = {
    enable        = true;
    platformTheme = "kde";
    style         = "kvantum";
  };

  environment.systemPackages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
   # catppuccin-sddm-corners
    (catppuccin-kde.override         { flavour = ["mocha"]; accents = ["mauve"]; winDecStyles = ["classic"]; })
    (catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
    (catppuccin-kvantum.override     { variant = "mocha"; accent = "mauve"; })
  ];
}
