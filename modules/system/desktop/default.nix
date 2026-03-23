{ desktopType ? "kde", ... }:

{
  imports = [
    ./hardware-nvidia.nix
    ./gaming.nix
  ] ++ (if desktopType == "gnome"
        then [ ./gnome.nix ]
        else if desktopType == "hyprland"
        then [ ./hyprland.nix ]
        else [ ./plasma.nix ]);
}
