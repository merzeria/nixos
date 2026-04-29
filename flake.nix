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
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, lsfg-vk-flake, ... }@inputs:
    let
      system   = "x86_64-linux";
      username = "simon";

      mkDesktop = { themeName, desktopType ? "kde" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs themeName desktopType; isLaptop = false; };
          modules = [
            ./hosts/desktop
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs      = true;
              home-manager.useUserPackages    = true;
              home-manager.extraSpecialArgs   = { inherit inputs themeName desktopType; isLaptop = false; };
              home-manager.users.${username}  =
                if desktopType == "gnome"         then import ./modules/home/desktop/gnome
                else if desktopType == "cinnamon" then import ./modules/home/desktop/cinnamon
                else import ./modules/home/desktop;
            }
            lsfg-vk-flake.nixosModules.default
          ];
        };

      mkLaptop = { themeName, desktopType ? "kde" }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs themeName desktopType; isLaptop = true; };
          modules = [
            ./hosts/laptop
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs      = true;
              home-manager.useUserPackages    = true;
              home-manager.extraSpecialArgs   = { inherit inputs themeName desktopType; isLaptop = true; };
              home-manager.users.${username}  =
                if desktopType == "gnome"         then import ./modules/home/laptop/gnome
                else if desktopType == "cinnamon" then import ./modules/home/laptop/cinnamon
                else import ./modules/home/laptop;
            }
          ];
        };

    in {
      nixosConfigurations = {
        sweet      = mkDesktop { themeName = "sweet";      };
        nordic     = mkDesktop { themeName = "nordic";     };
        dracula    = mkDesktop { themeName = "dracula";    };
        catppuccin = mkDesktop { themeName = "catppuccin"; };
        dragonized = mkDesktop { themeName = "dragonized"; };

        desktop-gnome    = mkDesktop { themeName = "catppuccin"; desktopType = "gnome"; };
        desktop-cinnamon = mkDesktop { themeName = "catppuccin"; desktopType = "cinnamon"; };

        laptop-sweet      = mkLaptop { themeName = "sweet";      };
        laptop-nordic     = mkLaptop { themeName = "nordic";     };
        laptop-dracula    = mkLaptop { themeName = "dracula";    };
        laptop-catppuccin = mkLaptop { themeName = "catppuccin"; };
        laptop-dragonized = mkLaptop { themeName = "dragonized"; };

        laptop-gnome     = mkLaptop { themeName = "catppuccin"; desktopType = "gnome"; };
        laptop-cinnamon  = mkLaptop { themeName = "catppuccin"; desktopType = "cinnamon"; };
      };
    };
}
