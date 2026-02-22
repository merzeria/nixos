# modules/system.nix
{ config, pkgs, themeName, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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

  i18n = {
  # Base language
  defaultLocale = "en_GB.UTF-8";

  # Make sure the locales we need are actually built
  supportedLocales = [
    "en_GB.UTF-8/UTF-8"
    "da_DK.UTF-8/UTF-8"
  ];

  # Override the categories that should follow Danish conventions
  extraLocaleSettings = {
    LC_ADDRESS        = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT    = "da_DK.UTF-8";
    LC_MONETARY       = "da_DK.UTF-8";
    LC_NAME           = "da_DK.UTF-8";
    LC_NUMERIC        = "da_DK.UTF-8";
    LC_PAPER          = "da_DK.UTF-8";
    LC_TELEPHONE      = "da_DK.UTF-8";
    LC_TIME           = "da_DK.UTF-8";
  };
};

  # Automatic garbage collection
  nix.settings.auto-optimise-store = true; # Deduplicates files to save space
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
};

  # --------------------------------------------------------------
  # Graphics / NVIDIA
  # --------------------------------------------------------------
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Critical for Steam/older games
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true; # Required for Plasma 6 Wayland
    powerManagement.enable = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # --------------------------------------------------------------
  # Display manager & Plasma
  # --------------------------------------------------------------
  services.xserver.enable = true;
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "catppuccin-sddm-corners";
    };
    autoLogin = {
      enable = true;
      user = "simon";
    };
  };
# This creates the theme configuration for SDDM
  environment.etc."sddm-catppuccin-config.conf".text = ''
    [General]
    Flavor="mocha"
    Accent="mauve"
  '';
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
 # fileSystems."/mnt/games" = {
  #  device = "/dev/disk/by-uuid/d213c7a5-7c19-4001-947f-d849737cef60";
   # fsType = "ext4";
    #options = [ "nofail" ];
  #};

  # --------------------------------------------------------------
  # Users (system‑side part)
  # --------------------------------------------------------------
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Halberg";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
  };

  # Make Zsh the default shell for the user system-wide
  programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;
  };
  users.users.simon.shell = pkgs.zsh;

  # --------------------------------------------------------------
  # Unfree packages & Flatpaks
  # --------------------------------------------------------------
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  # --------------------------------------------------------------
  # Global system packages (outside of Home‑Manager)
  # --------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    vim
    wget
    usbutils
    git
    kdePackages.qtstyleplugin-kvantum # Kvantum for KDE
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-sddm-corners
   # 1. The KDE Theme (Mocha Mauve)
    (catppuccin-kde.override {
      flavour = [ "mocha" ];
      accents = [ "mauve" ];
      winDecStyles = [ "classic" ]; # Try classic for smaller buttons
    })

    # 2. The Folder Icons (Mocha Mauve)
    (catppuccin-papirus-folders.override {
      flavor = "mocha";
      accent = "mauve";
    })
  ];

  # --------------------------------------------------------------
  # Steam & Games
  # --------------------------------------------------------------
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };
  programs.gamemode.enable = true;

  # --------------------------------------------------------------
  # State version (keep what you already have)
  # --------------------------------------------------------------
  system.stateVersion = "25.11";
}
