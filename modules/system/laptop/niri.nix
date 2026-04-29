{ pkgs, ... }: {
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    awww
    grim
    slurp
    swaylock
  ];
}
