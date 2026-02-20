{
  description = "My NixOS + Home Manager + Plasma Manager configuration";

  # -----------------------------------------------------------------
  # Inputs – where we fetch external repos
  # -----------------------------------------------------------------
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";   # or stable if you prefer
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Optional: flake-utils for easier outputs
    flake-utils.url = "github:numtide/flake-utils";
  };

  # -----------------------------------------------------------------
  # Outputs – what we actually build
  # -----------------------------------------------------------------
  outputs = { self, nixpkgs, nixos-hardware, home-manager, plasma-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;
        # Your user name
        username = "simon";
        # Host name
        hostName = "nixos";
      in {
        # -----------------------------------------------------------------
        # NixOS configuration
        # -----------------------------------------------------------------
        nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # Core system config (hardware, base packages, etc.)
            ./hardware-configuration.nix
            ./modules/plasma.nix          # optional extra plasma tweaks
            ./modules/home.nix            # home‑manager module
            # Enable the flake itself as a module so we can reference its attrs
            ({ config, pkgs, ... }: {
              # Basic system settings
              networking.hostName = hostName;
              time.timeZone = "Europe/Copenhagen";   # adjust to your zone
              i18n.defaultLocale = "en_GB.UTF-8";

             i18n.extraLocaleSettings = {
            LC_ADDRESS = "da_DK.UTF-8";
            LC_IDENTIFICATION = "da_DK.UTF-8";
            LC_MEASUREMENT = "da_DK.UTF-8";
            LC_MONETARY = "da_DK.UTF-8";
            LC_NAME = "da_DK.UTF-8";
            LC_NUMERIC = "da_DK.UTF-8";
            LC_PAPER = "da_DK.UTF-8";
            LC_TELEPHONE = "da_DK.UTF-8";
            LC_TIME = "da_DK.UTF-8";
             };
             
              # Enable the Plasma desktop via plasma-manager
              imports = [
                plasma-manager.nixosModules.plasma-manager
              ];
              programs.plasma.enable = true;

              # Enable Home Manager for the user
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./modules/home.nix;
            })
          ];
        };
      });
}