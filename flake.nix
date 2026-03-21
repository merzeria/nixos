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

      # ──────────────────────────────────────────────────────
      # Desktop builder
      # desktopType = "kde" (default) | "gnome"
      # themeName   = only meaningful for KDE configs
      # ──────────────────────────────────────────────────────
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
                if desktopType == "gnome"
                then import ./modules/home/desktop/gnome
                else import ./modules/home/desktop;
            }
            lsfg-vk-flake.nixosModules.default
          ];
        };

      # ──────────────────────────────────────────────────────
      # Laptop builder
      # desktopType = "kde" (default) | "gnome"
      # Niri is always present regardless of desktopType
      # ──────────────────────────────────────────────────────
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
                if desktopType == "gnome"
                then import ./modules/home/laptop/gnome
                else import ./modules/home/laptop;
            }
          ];
        };

    in {
      nixosConfigurations = {
        # ── Desktop: KDE themes ──────────────────────────────
        sweet      = mkDesktop { themeName = "sweet";      };
        nordic     = mkDesktop { themeName = "nordic";     };
        dracula    = mkDesktop { themeName = "dracula";    };
        catppuccin = mkDesktop { themeName = "catppuccin"; };
        dragonized = mkDesktop { themeName = "dragonized"; };

        # ── Desktop: GNOME ───────────────────────────────────
        # themeName is passed but ignored by the GNOME home module;
        # it satisfies the specialArgs contract without causing issues.
        desktop-gnome = mkDesktop { themeName = "catppuccin"; desktopType = "gnome"; };

        # ── Laptop: KDE themes ───────────────────────────────
        laptop-sweet      = mkLaptop { themeName = "sweet";      };
        laptop-nordic     = mkLaptop { themeName = "nordic";     };
        laptop-dracula    = mkLaptop { themeName = "dracula";    };
        laptop-catppuccin = mkLaptop { themeName = "catppuccin"; };
        laptop-dragonized = mkLaptop { themeName = "dragonized"; };

        # ── Laptop: GNOME (Niri still available as a session) ─
        laptop-gnome = mkLaptop { themeName = "catppuccin"; desktopType = "gnome"; };
      };
    };
}
