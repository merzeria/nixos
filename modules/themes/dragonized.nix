{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      cursor.theme = "Sweet-cursors";
      iconTheme = "candy-icons";
      colorScheme = "Sweet";
      wallpaper = ./wallpapers/sweetnix.png;
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Sweet-Dark-transparent";
      splashScreen.theme = "Sweet";
    };

    configFile = {
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "kvantumrc"."General"."theme" = "Sweet-transparent-toolbar";
    };

    panels = [
      # --- MONITOR 1 (Main) ---
      {
        location = "top";
        height = 26;
        screen = 0;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.windowtitle" # This is built-in to Plasma 6!
          "org.kde.plasma.appmenu" # Global Menu
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
      {
        location = "bottom";
        height = 48;
        screen = 0;
        alignment = "center";
        lengthMode = "fit";
        floating = true;
        hiding = "dodgewindows"; # This makes the dock hide when a window covers it
        widgets = [ "org.kde.plasma.icontasks" ];
      }

      # --- MONITOR 2 (Secondary) ---
      {
        location = "top";
        height = 26;
        screen = 1;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
      {
        location = "bottom";
        height = 48;
        screen = 1;
        alignment = "center";
        lengthMode = "fit";
        floating = true;
        hiding = "dodgewindows";
        widgets = [ "org.kde.plasma.icontasks" ];
      }
    ];
  };

  home.packages = with pkgs; [
    sweet-nova
    sweet
    candy-icons
  ];
}
