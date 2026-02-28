{ pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-sddm-corners";
    };
    autoLogin = {
      enable = lib.mkForce false;
      user = "simon";
    };
  };

  # SDDM Theme Config
  environment.etc."sddm-catppuccin-config.conf".text = ''
    [General]
    Flavor="mocha"
    Accent="mauve"
  '';

  # Theme Engine
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "kvantum";
  };

  # --- GNOME specialisation ---
  specialisation.gnome.configuration = {
    imports = [ ./gnome.nix ];
  };
}
