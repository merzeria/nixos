{ config, pkgs, ... }:

{
  # Graphics / NVIDIA
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Audio / PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Persist ALSA mixer settings (e.g. headset volume levels) across reboots
  # alsa-utils must be in systemPackages (it is, in users.nix)
  systemd.services.alsa-store.enable = true;
  systemd.services.alsa-restore.enable = true;

  # Power Management & Printing
  services.printing.enable = true;
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.logind.settings.Login = {
    IdleAction = "ignore";
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  # This adds the necessary udev rules for VIA/VIAL web editors
  services.udev.packages = with pkgs; [
    via
    vial
  ];
}
