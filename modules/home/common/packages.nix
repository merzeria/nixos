{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    htop
    floorp-bin
    pwvucontrol
    equibop
    rclone
  ];
}
