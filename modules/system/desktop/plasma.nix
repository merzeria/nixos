{ pkgs, lib, ... }:

{
  services.xserver.enable              = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable              = true;

  services.displayManager = {
    plasma-login-manager = {
      enable          = true;
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
}
