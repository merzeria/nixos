{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "com.github.vinceliuice.Nordic";
      cursor.theme = "Nordic-cursors";
      iconTheme = "Papirus-Dark";
      colorScheme = "Nordic";
    };

    # Direct config for Nordic window decorations (Aurorae)
    configFile."kwinrc"."org.kde.kdecoration2" = {
      library = "org.kde.kwin.aurorae";
      theme = "__aurorae__svg__Nordic";
    };

    # Enable blur (optional, looks great with Nordic)
    configFile."kwinrc"."Plugins".blurEnabled = true;

    panels = [
      {
        location = "bottom";
        height = 44;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };

  home.packages = with pkgs; [
    nordic             # Provides the Global Theme, Cursors, and Colors
    papirus-icon-theme # Standard companion for Nordic
  ];
}
