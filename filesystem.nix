# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [];

 fileSystems."/run/media/simon/d213c7a5-7c19-4001-947f-d849737cef60" = {
   device = "/dev/nvme0n1p1";
   fsType = "ext4";
   options = [ 
    "nofail" # Prevent system from failing if this drive doesn't mount
   ];
 };
}
