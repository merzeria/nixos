{ desktopType ? "kde", ... }:

{
  imports = [
    ./hardware-intel.nix
    ./gaming.nix
    ./niri.nix
  ] ++ (if desktopType == "gnome"
        then [ ./gnome.nix ]
        else if desktopType == "hyprland"
        then [ ./hyprland.nix ]
        else [ ./kde.nix ]);
}
