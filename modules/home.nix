{ config, pkgs, ... }:

{
  # Let Home Manager manage the user’s profile
  home.stateVersion = "25.11";   # keep in sync with your NixOS version

  # Basic packages you probably want in your user environment
  home.packages = with pkgs; [
    neovim
    git
    ripgrep
    fd
    htop
    wget
    curl
  ];

  # Example: enable Zsh with a simple prompt
  programs.zsh.enable = true;
  programs.zsh.promptInit = ''
    PROMPT='%F{cyan}%n@%m %F{yellow}%~ %F{reset}$ '
  '';

  # Example: set a GTK theme (affects Qt apps too via qt5ct)
  gtk = {
    enable = true;
    theme = "Adwaita-dark";
    iconTheme = "Papirus-Dark";
  };

  # Example: enable the KDE Connect integration
  services.kdeconnect.enable = true;
}