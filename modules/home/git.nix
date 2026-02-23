{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Simon Halberg";
    userEmail = "stwhal@protonmail.com";
    settings = {
      init.defaultBranch = "main";
      safe.directory = [ "/home/simon/simonos" "/etc/nixos" ];
    };
  };
}
