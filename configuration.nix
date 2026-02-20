sudo tee /etc/nixos/configuration.nix > /dev/null <<'EOF'
{ config, pkgs, ... }:

{
  # Enable flakes and the newer Nix command
  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Import the flake we just built
  imports = [
    (builtins.getFlake "file:///home/simon/nixos-flake").nixosConfigurations.nixos.config
  ];
}
EOF