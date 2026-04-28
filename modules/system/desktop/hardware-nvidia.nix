{ config, pkgs, ... }:

{
  # NVIDIA kernel param
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Graphics
  hardware.graphics = {
    enable    = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable     = true;
    powerManagement.enable = true;
    open                   = true;
    package                = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Audio / PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable      = true;
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
  };

  # Persist ALSA mixer settings (fixes headset single-side audio across reboots)
  systemd.services.alsa-store.enable   = true;
  systemd.services.alsa-restore.enable = true;

  # Disable sleep/suspend — desktop stays on
  services.printing.enable = true;
  systemd.targets.sleep.enable         = false;
  systemd.targets.suspend.enable       = false;
  systemd.targets.hibernate.enable     = false;
  systemd.targets.hybrid-sleep.enable  = false;

  services.logind.settings.Login = {
    IdleAction                  = "ignore";
    HandleLidSwitch             = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked       = "ignore";
  };

  # udev rules for VIA/VIAL keyboard editors
  services.udev.packages = with pkgs; [ via vial ];

  # Desktop-only system packages
  environment.systemPackages = with pkgs; [
    gamescope-wsi
    goverlay
    protontricks
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-sddm-corners
    catppuccin-plymouth
    (catppuccin-kde.override         { flavour = ["mocha"]; accents = ["mauve"]; winDecStyles = ["classic"]; })
    (catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
    (catppuccin-kvantum.override     { variant = "mocha"; accent = "mauve"; })
  ];
}
