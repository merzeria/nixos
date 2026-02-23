{ pkgs, ... }:

{
  users.users.simon = {
    isNormalUser = true;
    description = "Simon Halberg";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    usbutils
    alsa-utils
    fastfetch
    gamescope-wsi
    goverlay
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-sddm-corners
    catppuccin-plymouth
    (catppuccin-kde.override { flavour = ["mocha"]; accents = ["mauve"]; winDecStyles = ["classic"]; })
    (catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
    (catppuccin-kvantum.override { variant = "mocha"; accent = "mauve"; })
  ];
}
