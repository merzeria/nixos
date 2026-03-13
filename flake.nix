{
  description = "Simon's NixOS + Home-Manager + Plasma-Manager flake";

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
    
noctalia = {
  url = "github:noctalia-dev/noctalia-shell";
  inputs.nixpkgs.follows = "nixpkgs";
};
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, ... }@inputs:
    let
      system   = "x86_64-linux";
      username = "simon";

      # Desktop: KDE + themes + GNOME specialisation + NVIDIA + gaming
      mkDesktop = themeName: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs themeName; };
        modules = [
          ./hosts/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs      = true;
            home-manager.useUserPackages    = true;
            home-manager.extraSpecialArgs   = { inherit inputs themeName; };
            home-manager.users.${username}  = import ./modules/home/desktop;
          }
        ];
      };

      # Laptop: Intel iGPU + TLP
      mkLaptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs themeName; };
        modules = [
          ./hosts/laptop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs      = true;
            home-manager.useUserPackages    = true;
            home-manager.extraSpecialArgs   = { inherit inputs themeName; };
            home-manager.users.${username}  = import ./modules/home/laptop;
          }
        ];
      };

    in {
      nixosConfigurations = {
        # Desktop themes — switch with e.g. set-catppuccin
        sweet      = mkDesktop "sweet";
        nordic     = mkDesktop "nordic";
        dracula    = mkDesktop "dracula";
        catppuccin = mkDesktop "catppuccin";
        dragonized = mkDesktop "dragonized";

        # Laptop
        laptop-sweet      = mkLaptop "sweet";
        laptop-nordic     = mkLaptop "nordic";
        laptop-dracula    = mkLaptop "dracula";
        laptop-catppuccin = mkLaptop "catppuccin";
        laptop-dragonized = mkLaptop "dragonized";
      };
    };
}
