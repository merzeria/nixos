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
      enable = true;
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
  # --- Gnome specialisation ---
  specialisation.gnome.configuration = {
    # Turn off the KDE stuff defined above
    services.desktopManager.plasma6.enable = lib.mkForce false;
    services.displayManager.sddm.enable = lib.mkForce false;

    # Turn on GNOME
    services.xserver.desktopManager.gnome.enable = true;
    services.displayManager.gdm.enable = true;
    services.displayManager.gdm.wayland = true;

    # Import your new dedicated theme file
    imports = [ ../themes/gnome-cat.nix ];

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-extension-manager
      catppuccin-kvantum
      glib
    ];
  };
}
