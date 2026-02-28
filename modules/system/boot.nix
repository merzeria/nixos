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
    entry=$(ls /boot/loader/entries/ 2>/dev/null | grep specialisation-gnome | sort -t- -k3 -n | tail -1 | sed 's/\.conf$//')
    if [ -n "$entry" ]; then
      sed -i "s/^default .*/default $entry.conf/" /boot/loader/loader.conf
    fi
  '';
}
