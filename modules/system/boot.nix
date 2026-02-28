{ pkgs, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    consoleLogLevel = 0;

    kernelParams = [
      "quiet"
      "splash"
      "vga=current"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "nvidia-drm.modeset=1"
    ];

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      timeout = 5;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "catppuccin-mocha";
      themePackages = [
        (pkgs.catppuccin-plymouth.override { variant = "mocha"; })
      ];
    };
  };

  # Set GNOME specialisation as default boot entry after bootloader writes loader.conf
  system.activationScripts.gnomeBootDefault = ''
    entry=$(${pkgs.coreutils}/bin/ls /boot/loader/entries/ 2>/dev/null | ${pkgs.gnugrep}/bin/grep specialisation-gnome | ${pkgs.coreutils}/bin/sort -t- -k3 -n | ${pkgs.coreutils}/bin/tail -1 | ${pkgs.gnused}/bin/sed 's/\.conf$//')
    if [ -n "$entry" ]; then
      ${pkgs.gnused}/bin/sed -i "s/^default .*/default $entry.conf/" /boot/loader/loader.conf
    fi
  '';
}
