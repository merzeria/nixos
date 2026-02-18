{ config, lib, pkgs, ... }:

{
  imports =
    [];

 fileSystems."/mnt/games" = {
   device = "/dev/disk/by-uuid/d213c7a5-7c19-4001-947f-d849737cef60";
   fsType = "ext4";
   options = [ "nofail" ];
 };
}
