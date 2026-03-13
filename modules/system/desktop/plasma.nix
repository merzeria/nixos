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

  # GNOME specialisation — selected from the bootloader to avoid KDE/Electron crashes
  specialisation.gnome.configuration = {
    imports = [ ./gnome.nix ];
  };

  # On every rebuild, set the GNOME specialisation as the default boot entry.
  # KDE is still reachable by choosing it manually in the bootloader menu.
  system.activationScripts.gnomeBootDefault = ''
    entry=$(${pkgs.coreutils}/bin/ls /boot/loader/entries/ 2>/dev/null \
      | ${pkgs.gnugrep}/bin/grep specialisation-gnome \
      | ${pkgs.coreutils}/bin/sort -t- -k3 -n \
      | ${pkgs.coreutils}/bin/tail -1 \
      | ${pkgs.gnused}/bin/sed 's/\.conf$//')
    if [ -n "$entry" ]; then
      ${pkgs.gnused}/bin/sed -i "s/^default .*/default $entry.conf/" /boot/loader/loader.conf
    fi
  '';
}
