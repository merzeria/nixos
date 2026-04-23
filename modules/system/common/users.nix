{ pkgs, ... }:

{
  users.users.simon = {
    isNormalUser  = true;
    description   = "Simon Halberg";
    extraGroups   = [ "networkmanager" "wheel" "video" "audio" "adbusers" ];
    shell         = pkgs.zsh;
  };

  programs.zsh = {
    enable              = true;
    enableCompletion    = true;
    autosuggestions.enable    = true;
    syntaxHighlighting.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    usbutils
    alsa-utils
    fastfetch
    restic
    android-tools
    kdePackages.plasma-browser-integration
  ];
}
