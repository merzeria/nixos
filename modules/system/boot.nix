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
        # Boot into GNOME specialisation by default
        # Entry name matches /boot/loader/entries/nixos-specialisation-gnome.conf
        extraInstallCommands = ''
          entry=$(ls /boot/loader/entries/ | grep specialisation-gnome | sort -t- -k3 -n | tail -1 | sed 's/\.conf//')
          if [ -n "$entry" ]; then
            sed -i "s/^default .*/default $entry/" /boot/loader/loader.conf
          fi
        '';
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
}
