{ pkgs, ... }:
{
  imports = [
    ../../packages.nix
    ../../shell.nix
    ../../git.nix
    # add other shared home modules you want
  ];

  home.packages = with pkgs; [
    # Cinnamon-specific apps you want
  ];
}
