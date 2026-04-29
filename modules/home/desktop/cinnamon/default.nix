{ pkgs, ... }:
{
  imports = [
    ../../common
    ../packages.nix
    ../desktop.nix
    # add other shared home modules you want
  ];

  home.packages = with pkgs; [
    # Cinnamon-specific apps you want
  ];
}
