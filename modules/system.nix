# modules/system.nix
{ config, pkgs, ... }:

{
  # --------------------------------------------------------------
  # Bootloader & kernel
  # --------------------------------------------------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # --------------------------------------------------------------
  # Basic system settings
  # --------------------------------------------------------------
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Copenhagen";

  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS       = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT  = "da_DK.UTF-8";
    LC_MONETARY     = "da_DK.UTF-8";
    LC_NAME         = "da_DK.UTF-8";
    LC_NUMERIC      = "da_DK.UTF-8";
    LC_PAPER        = "da_DK.UTF-8";
    LC_TELEPHONE    = "da_DK.UTF-8";
    LC_TIME         = "da_DK.UTF-8";
  };

  # Auto‑upgrade (kept exactly as you had it)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # --------------------------------------------------------------
  # Graphics / NVIDIA
  # --------------------------------------------------------------
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # --------------------------------------------------------------
  # Display manager & Plasma
  # --------------------------------------------------------------
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # X11 keymap
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };
  console.keyMap = "dk-latin1";

  # --------------------------------------------------------------
  # Audio / PipeWire
  # --------------------------------------------------------------
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;   # uncomment if you need JACK
  };

  # --------------------------------------------------------------
  # Printing
  # --------------------------------------------------------------
  services.printing.enable = true;

  # --------------------------------------------------------------
  # Filesystems (your games partition)
  # --------------------------------------------------------------
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/d213c7a5-7c19-4001-947f-d849737cef60";
    fsType = "ext4";
    options = [ "nofail" ];
  };

  # --------------------------------------------------------------
  # Users (system‑side part)
  # --------------------------------------------------------------
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Halberg";
    extraGroups = [ "networkmanager" "wheel" ];
    # Packages that belong to the *system* profile (not per‑user)
    packages = with pkgs; [
      vesktop
      floorp-bin
      pwvucontrol
      gamescope-wsi
      duckstation
      pcsx2
    ];
  };

  # Automatic login (still handled by the system)
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "simon";

  # --------------------------------------------------------------
  # Unfree packages
  # --------------------------------------------------------------
  nixpkgs.config.allowUnfree = true;

  # --------------------------------------------------------------
  # Global system packages (outside of Home‑Manager)
  # --------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    vim
    wget
    usbutils
  ];

  # --------------------------------------------------------------
  # Steam
  # --------------------------------------------------------------
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.gamemode.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [ proton-ge-bin ];

  # --------------------------------------------------------------
  # State version (keep what you already have)
  # --------------------------------------------------------------
  system.stateVersion = "25.11";
}