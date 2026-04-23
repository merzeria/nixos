{ ... }:

{
  imports = [
    ./packages.nix
    ./shell.nix
    ./git.nix
  ];

  home.username     = "simon";
  home.homeDirectory = "/home/simon";
  home.stateVersion = "25.11";
}
