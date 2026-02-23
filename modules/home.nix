# modules/home.nix
{ inputs, pkgs, themeName, lib, ... }:

{
  imports = [
    # Pull in the Plasma-Manager module from flake inputs
    inputs.plasma-manager.homeModules.plasma-manager
    # Import your specific theme logic
    (import ./plasma.nix { inherit pkgs themeName; })
  ];

  home.username = "simon";
  home.stateVersion = "25.11";

  #language settings:
  home.language = {
  base = "en_GB.UTF-8";
  address = "da_DK.UTF-8";
  monetary = "da_DK.UTF-8";
  paper = "da_DK.UTF-8";
  time = "da_DK.UTF-8";
  telephone = "da_DK.UTF-8";
  measurement = "da_DK.UTF-8";
  name = "da_DK.UTF-8";
  numeric = "da_DK.UTF-8";
};

  #installed packages
  home.packages = with pkgs; [
    pcsx2
    neovim
    htop
    floorp-bin
    pwvucontrol
    lutris
    equibop
  ];

  programs.mangohud = {
    enable = true;
    # Optional: Enable it for all sessions (this adds MANGOHUD=1 to your env)
    # enableSessionWide = true;
    settings = {
      full = true;
      no_display = true; # Starts hidden; use Shift_R+F12 to toggle in-game
      cpu_temp = true;
      gpu_temp = true;
      fps_limit = 120;
    };
  };

# Variables for Steam
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${pkgs.proton-ge-bin}/bin";
    };

  programs.zsh = {
    enable = true;
    shellAliases = {
      # Use 'test' for temporary theme changes (no bootloader clutter)
      sweet = "sudo nixos-rebuild test --flake ~/simonos/#sweet";
      nordic = "sudo nixos-rebuild test --flake ~/simonos/#nordic";
      dracula = "sudo nixos-rebuild test --flake ~/simonos/#dracula";
      catppuccin = "sudo nixos-rebuild test --flake ~/simonos/#catppuccin";
      dragonized = "sudo nixos-rebuild test --flake ~/simonos/#dragonized";

      # Use 'set-sweet' or 'set-nordic' to make it permanent
      set-sweet = "sudo nixos-rebuild switch --flake ~/simonos/#sweet";
      set-nordic = "sudo nixos-rebuild switch --flake ~/simonos/#nordic";
      set-dracula = "sudo nixos-rebuild switch --flake ~/simonos/#dracula";
      set-catppuccin = "sudo nixos-rebuild switch --flake ~/simonos/#catppuccin";
      set-dragonized = "sudo nixos-rebuild switch --flake ~/simonos/#dragonized";

      # Git backup
      push-nix = "cd ~/simonos && git add . && git commit -m \"Update: $(date +%Y-%m-%d)\" && git push";
    };
    initContent = ''
    # Show system info and Nix logo first
    fastfetch
  '';
  };

  programs.starship = {
  enable = true;
  # Settings can be added here:
  settings = {
    # Link the palette to the theme
    palette = "catppuccin_mocha";

    # Customizing the prompt layout
    format = "[](mauve)$os$directory[](fg:mauve bg:surface0)$git_branch$git_status[](fg:surface0) $character";

    directory = {
      style = "bg:mauve fg:crust";
      format = "[ $path ]($style)";
    };

    os = {
      disabled = false;
      style = "bg:mauve fg:crust";
      symbols.NixOS = " ";
    };

    character = {
      success_symbol = "[󱄅](bold magenta)";
      error_symbol = "[󱄅](bold red)";
    };

    # Define the Catppuccin Mocha colors
    palettes.catppuccin_mocha = {
      rosewater = "#f5e0dc";
      flamingo = "#f2cdcd";
      pink = "#f5c2e7";
      mauve = "#cba6f7";
      red = "#f38ba8";
      maroon = "#eba0ac";
      peach = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      teal = "#94e2d5";
      sky = "#89dceb";
      sapphire = "#74c7ec";
      blue = "#89b4fa";
      lavender = "#b4befe";
      text = "#cdd6f4";
      subtext1 = "#bac2de";
      surface0 = "#313244";
      crust = "#11111b";
    };
  };
};

  programs.git = {
  enable = true;
  settings = {
    user = {
      name = "Simon Halberg";
      email = "stwhal@protonmail.com";
    };
    init.defaultBranch = "main";
    safe.directory = [ "/home/simon/simonos" "/etc/nixos" ];
    };
  };
    xdg.configFile."konsole/CatppuccinMocha.colorscheme".text = ''
  [General]
  Description=Catppuccin Mocha
  Opacity=0.9

  [Background]
  Color=#1e1e2e

  [Foreground]
  Color=#cdd6f4

  [Color0]
  Color=#45475a
  [Color0Intense]
  Color=#585b70
  '';
    # Declarative Autostart using standard XDG desktop files
  xdg.configFile = {
    "autostart/steam.desktop".text = ''
    [Desktop Entry]
    Name=Steam
    Exec=sh -c "sleep 10 && steam -silent %U"
    Type=Application
    Terminal=false
    Icon=steam
  '';

  "autostart/equibop.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Exec=sh -c "sleep 10 && equibop"
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name=equibop (Delayed)
    Comment=Starts equibop after KDE is settled to prevent crashes
  '';
  };
}
