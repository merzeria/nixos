{ desktopType ? "kde", ... }:

{
  imports = [
    ./hardware-nvidia.nix
    ./gaming.nix
  ] ++ (if desktopType == "gnome"
        then [ ./gnome.nix ]
        else [ ./plasma.nix ]);
}
