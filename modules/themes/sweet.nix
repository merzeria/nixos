{ pkgs, ... }:

{
  programs.plasma = {
    enable = true;
    workspace = {
      lookAndFeel = "com.github.vinceliuice.Sweet";
      cursor.theme = "Sweet-cursors"; # This refers to the name inside the package
      iconTheme = "Papirus-Dark";
      colorScheme = "Sweet";
    };

    # Direct config for window decorations (KDE 6 style)
    configFile."kwinrc"."org.kde.kdecoration2" = {
      library = "org.kde.kwin.aurorae";
      theme = "__aurorae__svg__Sweet";
    };

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
    sweet              # Provides the Global Theme and Cursors
    papirus-icon-theme # Provides the Icons
  ];
}
