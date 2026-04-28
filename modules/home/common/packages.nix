{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    htop
    brave
    pwvucontrol
    equibop
    rclone
    obsidian
    syncthing
    mediawriter
    spotify
  ];
}
