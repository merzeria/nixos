{
  description = "Simon’s NixOS + Home‑Manager + Plasma‑Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, plasma-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        username = "simon";          # <-- your Linux user name
        hostName = "nixos";          # <-- keep the same as in your old config
      in {
        nixosConfigurations.${hostName} = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # 1 Hardware detection (generated file)
            ./hardware-configuration.nix

            # 2 Your system‑wide options
            ./modules/system.nix

            # 3 Plasma‑manager module
            plasma-manager.nixosModules.plasma-manager

            # 4 Themes
            nixosConfigurations = {
        # Two *named* configurations – just change the suffix to pick a theme
        myhost-nordic = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            ./modules/system.nix
            (import ./modules/plasma.nix { inherit pkgs; themeName = "nordic"; })
            ./modules/home.nix
          ];
        };

        myhost-sweet = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            ./modules/system.nix
            (import ./modules/plasma.nix { inherit pkgs; themeName = "sweet"; })
            ./modules/home.nix
          ];
        };
      };
      
            # 5 Home‑Manager integration
            ({ config, pkgs, ... }: {
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./modules/home.nix;
            })
          ];
        };
      });
}