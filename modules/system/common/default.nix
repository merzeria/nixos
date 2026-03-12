{ ... }:

{
  imports = [
    ./boot.nix
    ./localization.nix
    ./users.nix
    ./backup.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store   = true;
  };

  nix.gc = {
    automatic = true;
    dates     = "weekly";
    options   = "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
