{ pkgs, ... }: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    swww
    grim
    slurp
    swaylock
  ];
}
