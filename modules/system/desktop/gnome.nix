{ pkgs, lib, config, ... }:

{
  services = {
    udev.packages = [ pkgs.gnome-settings-daemon ];

    displayManager.gdm.enable = true;

    desktopManager.gnome = {
      enable = true;

      # Fractional scaling + VRR + XWayland native scaling
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer', 'variable-refresh-rate', 'xwayland-native-scaling']
      '';
    };

    flatpak.enable = true;
  };

  # Suppress duplicate TTY login prompts — GDM handles auth
  systemd.services."getty@tty1".enable  = false;
  systemd.services."autovt@tty1".enable = false;

  # KDE Connect via the GNOME/GSConnect implementation
  programs.kdeconnect = {
    enable  = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  programs.dconf = {
    enable = true;
    # GDM login screen settings
    profiles.gdm.databases = [{
      settings = {
        "org/gnome/desktop/peripherals/keyboard".numlock-state = true;
        "org/gnome/desktop/input-sources".sources = [
          (lib.gvariant.mkTuple [ "xkb" config.services.xserver.xkb.layout ])
        ];
      };
    }];
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
    gnome-tweaks

    # Extensions
    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.burn-my-windows
    gnomeExtensions.tiling-shell
    gnomeExtensions.vitals
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.gsconnect
  ];

  environment.gnome.excludePackages = with pkgs; [
    tali
    iagno
    hitori
    atomix
    yelp
    geary
    xterm
    totem
    epiphany
    packagekit
    gnome-tour
    gnome-software
    gnome-contacts
    gnome-user-docs
    gnome-packagekit
    gnome-font-viewer
    gnome-music
  ];
}
