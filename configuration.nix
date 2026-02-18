# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Mount other harddrives
      ./filesystem.nix
    ];

  # Use the systemd-boot EFI boot loader.

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
 
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest; 

  networking.hostName = "nixos";  # Define your hostname.

  # Enable Flakes feature
  # nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto update system
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true; 

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen"; 

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.

  i18n.defaultLocale = "en_GB.UTF-8";
    console.keyMap = "dk";
  # Extra language settings
  i18n.extraLocaleSettings = {
   LC_ALL = "en_GB.UTF-8";
   LC_CTYPE = "da_DK.UTF8";
   LC_ADDRESS = "da_DK.UTF-8";
   LC_IDENTIFICATION = "da_DK.UTF-8";
   LC_MEASUREMENT = "da_DK.UTF-8";
   LC_MESSAGES = "da_DK.UTF-8";
   LC_MONETARY = "da_DK.UTF-8";
   LC_NAME = "da_DK.UTF-8";
   LC_NUMERIC = "da_DK.UTF-8";
   LC_PAPER = "da_DK.UTF-8";
   LC_TELEPHONE = "da_DK.UTF-8";
   LC_TIME = "da_DK.UTF-8";
   LC_COLLATE = "da_DK.UTF-8";
  };

  # enable OpenGL
	hardware.graphics = {
	 enable = true;
	};
  # allow unfree package support
	nixpkgs.config.allowUnfree = true;

  # nvidia driver support
	services.xserver.videoDrivers = [ "nvidia" ]; 
	hardware.nvidia = {
	modesetting.enable = true;
  # Power management - might not work well
	powerManagement.enable = false;
	# Turns off GPU when not in use if set to true
	powerManagement.finegrained = false;
	# use open source kernel module
	open = true;
	# enable nvidia settings
	nvidiaSettings = true;
	# driver select
	package = config.boot.kernelPackages.nvidiaPackages.beta;
};

  # Enable the X11 windowing system.
  services.xserver.enable = true; 
  # Desktop manager

	# services.desktopManager.gnome.enable = true; #gnome
	 services.desktopManager.plasma6.enable = true; #KDE


  # X server/login service. DEFAULT is LightDM
  # {
   services.displayManager.sddm.enable = true;
  # services.displayManager.gdm.enable = true;
  # }

  # Enable 32bit Opengl
	 hardware.graphics.enable32Bit = true;  

  # Configure keymap in X11
  services.xserver.xkb.layout = "dk"; 
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
 services.pipewire = {
    enable = true;
    pulse.enable = true;
 };

  # Define a user account. Don't forget to set a password with ‘passwd’.
 users.users.simon = {
   isNormalUser = true;
   home = "/home/simon";
   description = "Simon Halberg";
   extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
	};

  # Automatic login
	 services.displayManager.autoLogin.enable = true;
	 services.displayManager.autoLogin.user = "simon";
	

  environment.systemPackages = with pkgs; [
    vesktop
    floorp-bin
    pwvucontrol
    protonplus
    alsa-utils
    thunderbird-latest-unwrapped
	vim
	wget
  ];
	#Steam
	programs ={
		steam = { 
			enable = true;
			remotePlay.openFirewall = true;
			localNetworkGameTransfers.openFirewall = true;
		};
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  # enable = true;
  # enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?
}
