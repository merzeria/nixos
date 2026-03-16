{ ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
    ../../modules/system/common
    ../../modules/system/laptop
  ];
}
