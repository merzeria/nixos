{ pkgs, lib, ... }:

{
  # Intel UHD 620 iGPU — modesetting driver is handled automatically
  hardware.graphics = {
    enable      = true;
    extraPackages = with pkgs; [
      intel-media-driver  # VA-API hardware video decode
      libva-vdpau-driver
      libvdpau-va-gl
    ];
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
  
  # Disable power-profiles-daemon — conflicts with TLP (GNOME enables it by default)
  services.power-profiles-daemon.enable = false;
  
  # TLP — excellent ThinkPad battery management
  services.tlp = {
    enable = true;
    settings = {
      # Keep battery between 20–80% to extend lifespan
      START_CHARGE_THRESH_BAT0      = 20;
      STOP_CHARGE_THRESH_BAT0       = 80;
      # Performance on AC, efficiency on battery
      CPU_SCALING_GOVERNOR_ON_AC    = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT   = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC  = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  services.thermald.enable  = true;
  services.printing.enable  = true;

  # udev rules for VIA/VIAL keyboard editors
  services.udev.packages = with pkgs; [ 
  via 
  vial
  ];
  
  services.udev.extraRules = ''
  ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
  ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
'';
  
  # Fingerprint reader
  services.fprintd.enable = true;

  security.pam.services = {
    login.fprintAuth = lib.mkForce true;
    gdm.fprintAuth   = lib.mkForce true;
    sudo.fprintAuth  = lib.mkForce true;
  };
  # Disable Gnome keyring:
  services.gnome.gnome-keyring.enable = false;
  # KDE mousepad settings
  services.libinput = {
  enable = true;
  touchpad = {
    accelSpeed = "0.3";        # adjust between -1 and 1 to taste
    naturalScrolling = true;
    tapping = true;
    disableWhileTyping = true;
  };
  mouse = {
    accelSpeed = "0.3";        # for the trackpoint
    naturalScrolling = false;  # usually prefer normal scrolling on a mouse
  };
 };
}
