{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      cursor.theme = "Sweet-cursors";
      iconTheme = "candy-icons";
      colorScheme = "Sweet";
      windowDecorations.library = "org.kde.kwin.aurorae";
      windowDecorations.theme = "__aurorae__svg__Sweet-Dark-transparent";
    };

    configFile = {
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "kvantumrc"."General"."theme" = "Sweet-transparent-toolbar";
    };

    panels = [
      # --- THE TOP BAR (Global Menu & System Tray) ---
      {
        location = "top";
        height = 26;
        widgets = [
          "org.kde.plasma.kickoff"          # App Launcher
          "org.kde.plasma.appmenu"          # THE GLOBAL MENU (File, Edit, etc.)
          "org.kde.plasma.panelspacer"      # Pushes rest to the right
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }

      # --- THE BOTTOM DOCK (Icons-only Task Manager) ---
      {
        location = "bottom";
        height = 48;
        alignment = "center";               # Centers the dock
        lengthMode = "fit";                 # Makes it look like a dock, not a bar
        floating = true;                    # Plasma 6 floating effect
        widgets = [
          "org.kde.plasma.icontasks"        # Pinned and running apps
        ];
      }
    ];
  };

  home.packages = with pkgs; [
    sweet-nova
    candy-icons
  ];
}
