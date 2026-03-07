{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # Theme testing aliases
      sweet      = "sudo nixos-rebuild test --flake ~/simonos/#sweet";
      nordic     = "sudo nixos-rebuild test --flake ~/simonos/#nordic";
      dracula    = "sudo nixos-rebuild test --flake ~/simonos/#dracula";
      catppuccin = "sudo nixos-rebuild test --flake ~/simonos/#catppuccin";
      dragonized = "sudo nixos-rebuild test --flake ~/simonos/#dragonized";

      # Permanent switch aliases
      set-sweet      = "sudo nixos-rebuild switch --flake ~/simonos/#sweet";
      set-nordic     = "sudo nixos-rebuild switch --flake ~/simonos/#nordic";
      set-dracula    = "sudo nixos-rebuild switch --flake ~/simonos/#dracula";
      set-catppuccin = "sudo nixos-rebuild switch --flake ~/simonos/#catppuccin";
      set-dragonized = "sudo nixos-rebuild switch --flake ~/simonos/#dragonized";

      # Maintenance
      clean-nix  = "sudo nix-collect-garbage -d && nix-collect-garbage -d && nix-store --optimise";
      push-nix   = "cd ~/simonos && git add . && git commit -m \"Update: $(date +%Y-%m-%d)\" && git push";
      restic-check = "sudo B2_ACCOUNT_ID=$(grep B2_ACCOUNT_ID /etc/nixos/restic-b2-env | cut -d'\"' -f2) B2_ACCOUNT_KEY=$(grep B2_ACCOUNT_KEY /etc/nixos/restic-b2-env | cut -d'\"' -f2) restic -r b2:nixosbackup:simonos-backup -p /etc/nixos/restic-password snapshots";
    };

    initContent = ''
      fastfetch
      alias try="nix-shell -p"
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_mocha";
      format = "[](mauve)$os$directory[](fg:mauve bg:surface0)$git_branch$git_status[](fg:surface0) $character";

      nix_shell = {
        symbol = " ";
        format = "via [$symbol\\($name\\)]($style) ";
        style = "bold blue";
      };

      directory = { style = "bg:mauve fg:crust"; format = "[ $path ]($style)"; };
      os = { disabled = false; style = "bg:mauve fg:crust"; symbols.NixOS = " "; };
      character = { success_symbol = "[󱄅](bold magenta)"; error_symbol = "[󱄅](bold red)"; };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc"; flamingo = "#f2cdcd"; pink = "#f5c2e7"; mauve = "#cba6f7";
        red = "#f38ba8"; maroon = "#eba0ac"; peach = "#fab387"; yellow = "#f9e2af";
        green = "#a6e3a1"; teal = "#94e2d5"; sky = "#89dceb"; sapphire = "#74c7ec";
        blue = "#89b4fa"; lavender = "#b4befe"; text = "#cdd6f4"; subtext1 = "#bac2de";
        surface0 = "#313244"; crust = "#11111b";
      };
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };
}
