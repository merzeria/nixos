{ pkgs, lib, ... }:

{
  imports = [
    ../../common
    ../packages.nix
    ../desktop.nix   # autostart (Steam, equibop)
  ];

  # GNOME user settings via home-manager dconf
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout  = "appmenu:minimize,maximize,close";
      theme          = "adw-gtk3-dark";
      focus-mode     = "click";
      visual-bell    = false;
    };

    "org/gnome/desktop/interface" = {
      color-scheme        = "prefer-dark";
      cursor-theme        = "Adwaita";
      gtk-theme           = "adw-gtk3-dark";
      icon-theme          = "Papirus-Dark";
      monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
    };

    "org/gnome/desktop/background" = {
      picture-options  = "zoom";
      picture-uri      = "file://${pkgs.nixos-artwork.wallpapers.catppuccin-mocha}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-mocha.png";
      picture-uri-dark = "file://${pkgs.nixos-artwork.wallpapers.catppuccin-mocha}/share/backgrounds/nixos/nixos-wallpaper-catppuccin-mocha.png";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "caffeine@patapon.info"
        "gsconnect@andyholmes.github.io"
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "quick-settings-audio-panel@rayzeq.github.io"
        "rounded-window-corners-reborn@code@fxgn.dev"
        "blur-my-shell@aunetx"
        "burn-my-windows@schneegans.github.com"
        "tiling-shell@ferrarodomenico.com"
      ];
      favorite-apps = [
        "brave-browser.desktop"
        "steam.desktop"
        "org.equibop.Equibop.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      click-action              = "minimize-or-overview";
      disable-overview-on-startup = true;
      dock-position             = "BOTTOM";
      running-indicator-style   = "DOTS";
      multi-monitor             = true;
      always-center-icons       = true;
      custom-theme-shrink       = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling        = true;
    };

    "org/gnome/desktop/peripherals/keyboard".numlock-state = true;

    "org/gnome/desktop/input-sources".sources = [
      (lib.gvariant.mkTuple [ "xkb" "dk" ])
    ];
  };

  home.packages = with pkgs; [
    papirus-icon-theme
    nixos-artwork.wallpapers.catppuccin-mocha
  ];
}
