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
}
