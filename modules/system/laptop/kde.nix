{ pkgs, lib, ... }:
{
  services.xserver.enable              = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable              = true;

 services.displayManager = {
  sddm = {
    enable         = true;
    wayland.enable = true;
  };
  autoLogin = {
    enable = true;
    user   = "simon";
  };
};

  qt = {
    enable        = true;
    platformTheme = "kde";
    style         = "kvantum";
  };

  environment.systemPackages = with pkgs; [
  kdePackages.qtstyleplugin-kvantum
  catppuccin-cursors.mochaMauve    # add this
  (catppuccin-kde.override         { flavour = ["mocha"]; accents = ["mauve"]; winDecStyles = ["classic"]; })
  (catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
  (catppuccin-kvantum.override     { variant = "mocha"; accent = "mauve"; })
];
}
