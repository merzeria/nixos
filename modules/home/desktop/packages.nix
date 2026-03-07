{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pcsx2
    lutris
  ];

  programs.mangohud = {
    enable   = true;
    settings = {
      full       = true;
      no_display = true;
      cpu_temp   = true;
      gpu_temp   = true;
      fps_limit  = 120;
    };
  };
}
