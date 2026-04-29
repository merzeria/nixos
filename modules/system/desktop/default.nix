{ desktopType ? "kde", ... }:

{
  imports = [
    ./hardware-nvidia.nix
    ./gaming.nix
  ] ++ (if desktopType == "gnome"
        then [ ./gnome.nix ]
        else if desktopType == "cinnamon"
        then [ ./cinnamon.nix ]
        else [ ./plasma.nix ]);
}
