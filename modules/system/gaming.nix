{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    # extraCompatPackages handles Proton-GE automatically - no need for
    # STEAM_EXTRA_COMPAT_TOOLS_PATHS
  };

  programs.gamemode.enable = true;
}
