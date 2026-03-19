{ pkgs, lib, config, ... }:

{
  services = {
    udev.packages = [ pkgs.gnome-settings-daemon ];

    displayManager = {
      gdm = {
        enable         = true;
        wayland.enable = true;
      };
      # Autologin to GNOME when using this config.
      # Niri is still available as a session in the GDM session picker.
      autoLogin = {
        enable = true;
        user   = "simon";
      };
    };

    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer', 'variable-refresh-rate', 'xwayland-native-scaling']
      '';
    };

    flatpak.enable = true;

    # hardware-intel.nix disables gnome-keyring for KDE; restore it for GNOME
    gnome.gnome-keyring.enable = lib.mkForce true;
  };

  # Suppress duplicate TTY prompts
  systemd.services."getty@tty1".enable  = false;
  systemd.services."autovt@tty1".enable = false;

  programs.kdeconnect = {
    enable  = true;
    package = pkgs.gnomeExtensions.gsconnect;
  };

  programs.dconf = {
    enable = true;
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

    gnomeExtensions.caffeine
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.blur-my-shell
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
