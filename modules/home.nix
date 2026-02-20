# modules/home.nix
{ config, pkgs, ... }:

{
  # Home‑Manager version tracking – keep it in sync with your NixOS version
  home.stateVersion = "25.11";

  # Packages that should appear in the user’s `$HOME/.local/...` profile
  home.packages = with pkgs; [
    # Keep the same list you had under users.users.simon.packages
    vesktop
    floorp-bin
    pwvucontrol
    gamescope-wsi
    duckstation
    pcsx2

    # Anything else you want just for the user (feel free to add)
    neovim
    git
    htop
  ];

  # Extra groups – Home‑Manager can add the user to groups as well
  users.users.simon = {
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Example: enable Zsh (optional, you can delete if you use Bash)
  programs.zsh.enable = true;
  programs.zsh.promptInit = ''
    PROMPT='%F{cyan}%n@%m %F{yellow}%~ %F{reset}$ '
  '';
}