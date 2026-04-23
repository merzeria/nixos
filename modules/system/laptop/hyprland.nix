{ pkgs, ... }: {
  programs.hyprland = {
    enable  = true;
    package = pkgs.hyprland;
  };

  # Hyprlock PAM entry
  security.pam.services.hyprlock = {};

  # XDG portals (Hyprland needs both its own + GTK for file pickers)
  xdg.portal = {
    enable      = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  environment.systemPackages = with pkgs; [
    quickshell
    matugen
    eww
    grim
    slurp
    satty
    swappy
    mpvpaper
    yq-go
    playerctl
    cliphist
    hyprlock
    swayosd
    swaynotificationcenter
    pavucontrol
    networkmanager_dmenu
    wl-clipboard
    swww
    cava
    tree
    brightnessctl
    socat
    bc
    lm_sensors
    pamixer
    blueman
    python3
  ];
}
