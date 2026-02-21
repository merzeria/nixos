# modules/home.nix
{ inputs, pkgs, themeName, ... }:

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
    vesktop
    pcsx2
    neovim
    htop
    floorp-bin
    pwvucontrol
    gamescope-wsi
    lutris
    goverlay
    mangohud
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

      # Use 'set-sweet' or 'set-nordic' to make it permanent
      set-sweet = "sudo nixos-rebuild switch --flake ~/simonos/#sweet";
      set-nordic = "sudo nixos-rebuild switch --flake ~/simonos/#nordic";
      set-dracula = "sudo nixos-rebuild switch --flake ~/simonos/#dracula";

      # Git backup
      push-nix = "cd ~/simonos && git add . && git commit -m \"Update: $(date +%Y-%m-%d)\" && git push";
    };
    initContent = ''
      PROMPT='%F{cyan}%n@%m %F{yellow}%~ %F{reset}$ '
    '';
  };
}
