{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Simon Halberg";
        email = "stwhal@protonmail.com";
      };
      init.defaultBranch = "main";
      safe.directory = [ "/home/simon/simonos" "/etc/nixos" ];
    };
  };
}
