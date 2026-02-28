{ pkgs, lib, ... }:

{
  services.desktopManager.plasma6.enable = lib.mkForce false;
  services.displayManager.sddm.enable    = lib.mkForce false;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable   = true;
  services.displayManager.gdm.wayland  = true;

  qt.platformTheme = lib.mkForce "gnome";
  qt.style         = lib.mkForce "adwaita-dark";

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-music
    epiphany
    geary
    totem
  ];

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    glib
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.arcmenu
    gnomeExtensions.dash-to-dock
    gnomeExtensions.just-perfection
    (colloid-gtk-theme.override {
      themeVariants = [ "pink" ];
      colorVariants  = [ "dark" ];
      tweaks         = [ "rimless" "black" ];
    })
    colloid-icon-theme
    catppuccin-cursors.mochaMauve
    nerd-fonts.jetbrains-mono
  ];

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Apply dconf settings at system level
  programs.dconf.profiles.user.databases = [{
    lockAll = false;
    settings = with lib.gvariant; {
      "org/gnome/shell" = {
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "blur-my-shell@aunetx"
          "arcmenu@arcmenu.com"
          "dash-to-dock@micxgx.gmail.com"
          "just-perfection-desktop@just-perfection"
        ];
        disable-user-extensions = false;
      };

      "org/gnome/desktop/interface" = {
        color-scheme        = "prefer-dark";
        gtk-theme           = "Colloid-Pink-Dark";
        icon-theme          = "Colloid-Dark";
        cursor-theme        = "catppuccin-mocha-mauve-cursors";
        cursor-size         = mkUint32 24;
        font-name           = "Noto Sans 11";
        document-font-name  = "Noto Sans 11";
        monospace-font-name = "JetBrainsMono Nerd Font 10";
        enable-hot-corners  = false;
      };

      "org/gnome/mutter" = {
        experimental-features = [ "scale-monitor-framebuffer" ];
        edge-tiling           = true;
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        blur       = true;
        brightness = 0.75;
        pipeline   = "pipeline_default";
      };
      "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        blur       = true;
        brightness = 0.6;
        pipeline   = "pipeline_default_rounded";
      };
      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur     = true;
        pipeline = "pipeline_default";
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        dock-position           = "BOTTOM";
        dock-fixed              = false;
        intellihide             = true;
        autohide                = true;
        extend-height           = false;
        dash-max-icon-size      = mkInt32 48;
        show-trash              = false;
        show-mounts             = false;
        transparency-mode       = "FIXED";
        background-opacity      = 0.7;
        running-indicator-style = "DOTS";
        apply-custom-theme      = false;
      };

      "org/gnome/shell/extensions/arcmenu" = {
        menu-layout            = "Eleven";
        menu-button-appearance = "Icon";
      };

      "org/gnome/shell/extensions/just-perfection" = {
        panel-size                     = mkInt32 32;
        activities-button              = false;
        app-menu                       = false;
        search                         = true;
        animation                      = mkInt32 2;
        window-demands-attention-focus = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout  = "appmenu:minimize,maximize,close";
        num-workspaces = mkInt32 4;
        focus-mode     = "click";
      };

      "org/gnome/Console" = {
        font-name       = "JetBrainsMono Nerd Font 12";
        use-system-font = false;
      };
    };
  }];

  # Force theme settings on login to override any stale user dconf values
  # from previous KDE sessions
  systemd.user.services.gnome-theme-apply = {
    description = "Apply GNOME theme settings on login";
    wantedBy    = [ "graphical-session.target" ];
    after       = [ "graphical-session.target" ];
    serviceConfig = {
      Type      = "oneshot";
      ExecStart = pkgs.writeShellScript "gnome-theme-apply" ''
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme 'Colloid-Pink-Dark'
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme 'Colloid-Dark'
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme 'catppuccin-mocha-mauve-cursors'
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11'
        ${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrainsMono Nerd Font 10'
      '';
    };
  };
}
