{ pkgs, ... }:

{
  # Language settings
  home.language = {
    base = "en_GB.UTF-8";
    address = "da_DK.UTF-8";
    monetary = "da_DK.UTF-8";
    paper = "da_DK.UTF-8";
    time = "da_DK.UTF-8";
    telephone = "da_DK.UTF-8";
    measurement = "da_DK.UTF-8";
    name = "da_DK.UTF-8";
    numeric = "da_DK.UTF-8";
  };

  # User-specific packages
  home.packages = with pkgs; [
    pcsx2
    neovim
    htop
    floorp-bin
    pwvucontrol
    lutris
    equibop
    rclone
  ];

  # Variables for Steam
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "${pkgs.proton-ge-bin}/bin";
  };
  programs.mangohud = {
    enable = true;
    settings = {
      full = true;
      no_display = true;
      cpu_temp = true;
      gpu_temp = true;
      fps_limit = 120;
    };
  };
}
