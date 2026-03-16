{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    htop
    floorp-bin
    brave
    pwvucontrol
    equibop
    rclone
    obsidian
    syncthing
    mediawriter
  ];
}
