{
  description = "Simon’s NixOS + Home‑Manager + Plasma‑Manager flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      username = "simon";

      mkHost = themeName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          ./modules/system.nix
          home-manager.nixosModules.home-manager # Critical: Loads HM module
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs themeName; };
            home-manager.users.${username} = import ./modules/home.nix;
          }
        ];
      };
    in {
      nixosConfigurations = {
        sweet  = mkHost "sweet";
        nordic = mkHost "nordic";
      };
    };
}
