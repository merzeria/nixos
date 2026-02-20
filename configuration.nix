{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # This is the ONLY thing needed to allow you to use your flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # All other logic should be in ~/simonos/
  system.stateVersion = "25.11";
}
