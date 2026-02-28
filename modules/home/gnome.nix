{ pkgs, ... }:

{
  dconf.enable = true;

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name    = "catppuccin-mocha-mauve-cursors";
    package = pkgs.catppuccin-cursors.mochaMauve;
    size    = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name    = "Fluent-purple-Dark";
      package = pkgs.fluent-gtk-theme.override {
        themeVariants = [ "purple" ];
        colorVariants  = [ "dark" ];
        sizeVariants   = [ "standard" ];
        tweaks         = [ "round" "float" ];
      };
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Noto Sans";
      size = 11;
    };
  };

  dconf.settings = {
    # Enable extensions
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

    # Desktop appearance
    "org/gnome/desktop/interface" = {
      color-scheme          = "prefer-dark";
      gtk-theme             = "Fluent-purple-Dark";
      icon-theme            = "Papirus-Dark";
      cursor-theme          = "catppuccin-mocha-mauve-cursors";
      cursor-size           = 24;
      font-name             = "Noto Sans 11";
      document-font-name    = "Noto Sans 11";
      monospace-font-name   = "JetBrainsMono Nerd Font 10";
      enable-hot-corners    = false;
    };

    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
      edge-tiling           = true;
    };

    # Blur my Shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness   = 0.75;
      noise-amount = 0;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur         = true;
      brightness   = 0.75;
      pipeline     = "pipeline_default";
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur         = true;
      brightness   = 0.6;
      pipeline     = "pipeline_default_rounded";
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur         = true;
      pipeline     = "pipeline_default";
    };

    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position          = "BOTTOM";
      dock-fixed             = false;          # autohide
      intellihide            = true;           # dodge windows
      autohide               = true;
      extend-height          = false;          # don't fill full width
      dash-max-icon-size     = 48;
      show-trash             = false;
      show-mounts            = false;
      transparency-mode      = "FIXED";
      background-opacity     = 0.7;
      running-indicator-style = "DOTS";
      apply-custom-theme     = false;
    };

    # ArcMenu - modern grid layout
    "org/gnome/shell/extensions/arcmenu" = {
      menu-layout            = "Eleven";       # Windows 11 style grid
      menu-button-appearance = "Icon";
      custom-menu-button-icon-size = 22;
      runner-search-display-style = "List";
    };

    # Just Perfection - polish the shell
    "org/gnome/shell/extensions/just-perfection" = {
      panel-size             = 32;
      activities-button      = false;          # hide activities button
      app-menu               = false;          # hide app menu text
      search                 = true;
      workspace-switcher-should-show = false;
      animation              = 2;             # slightly faster animations
      window-demands-attention-focus = true;
    };

    # Window management
    "org/gnome/desktop/wm/preferences" = {
      button-layout   = "appmenu:minimize,maximize,close";
      num-workspaces  = 4;
      focus-mode      = "click";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-left  = [ "<Super>Left" ];
      switch-to-workspace-right = [ "<Super>Right" ];
    };

    # Fonts
    "org/gnome/Console" = {
      font-name        = "JetBrainsMono Nerd Font 12";
      use-system-font  = false;
    };
  };
}
