{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/run/current-system/sw/bin/proton-ge-bin";
  };
  programs.mangohud = {
    enable = true;
    settings = {
      full = true;
      no_display = true;
      cpu_temp = true;
      gpu_temp = true;
      fps_limit = 120;
    };
  };
}
