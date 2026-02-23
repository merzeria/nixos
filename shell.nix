{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # 1. The programs you want to "summon"
  packages = with pkgs; [
    hello     # A classic test program
    cowsay    # For the fun of it
    yt-dlp    # Great for testing media tools
    # Add any other packages here!
  ];

  # 2. Environment Variables (optional)
  # This is like 'export NAME=VALUE' but only inside this shell
  shellHook = ''
    echo "------------------------------------------"
    echo "Welcome to your Nix Testing Lab, Simon!"
    echo "Type 'exit' to clean up and leave."
    echo "------------------------------------------"

    # You can even set temporary aliases here
    alias hi="hello | cowsay"

    # This makes the shell look different so you don't forget where you are
    export PS1="[nix-lab:\w]$ "
  '';
}
