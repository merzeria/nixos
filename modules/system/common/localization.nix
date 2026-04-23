{ pkgs, ... }:

{
  # Set your time zone
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties
  i18n = {
    defaultLocale = "en_GB.UTF-8";

    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "da_DK.UTF-8/UTF-8"
    ];

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

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Configure X11/Plasma keymap
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };
}
