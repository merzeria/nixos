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
        username = "simon";          # your Linux user name
      in {
        # ---------------------------------------------------------
        # Two complete host configurations – just change the suffix
        # ---------------------------------------------------------

        nixosConfigurations.nixos-nordic = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            # 1️⃣ Hardware detection (generated file)
            ./hardware-configuration.nix

            # 2️⃣ System‑wide options (your old configuration.nix content)
            ./modules/system.nix

            # 3️⃣ Plasma‑manager core module
            plasma-manager.nixosModules.plasma-manager

            # 4️⃣ Theme selector – Nordic
            (import ./modules/plasma.nix { inherit pkgs; themeName = "nordic"; })

            # 5️⃣ Home‑Manager integration
            ({ config, pkgs, ... }: {
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./modules/home.nix;
            })
          ];
        };

        nixosConfigurations.nixos-sweet = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            ./modules/system.nix
            plasma-manager.nixosModules.plasma-manager
            (import ./modules/plasma.nix { inherit pkgs; themeName = "sweet"; })
            ({ config, pkgs, ... }: {
              home-manager.useUserPackages = true;
              home-manager.users.${username} = import ./modules/home.nix;
            })
          ];
        };
      });
}