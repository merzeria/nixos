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

    fonts = {
      general     = { family = "Noto Sans";               pointSize = 10; };
      fixedWidth  = { family = "JetBrainsMono Nerd Font"; pointSize = 10; };
      small       = { family = "Noto Sans";               pointSize = 8;  };
      toolbar     = { family = "Noto Sans";               pointSize = 10; };
      menu        = { family = "Noto Sans";               pointSize = 10; };
      windowTitle = { family = "Noto Sans"; pointSize = 10; weight = 700; };
    };

    configFile = {
      "kdeglobals"."General"."widgetStyle" = "kvantum";
      "kvantumrc"."General"."theme"        = "Sweet-transparent-toolbar";

      # Use the Sweet Konsole profile (same palette as dragonized)
      "konsolerc"."Desktop Entry"."DefaultProfile" = "Sweet.profile";

      # KWin Effects
      "kwinrc"."Plugins" = {
        blurEnabled                      = true;
        kwin4_effect_translucencyEnabled = true;
        slidebackEnabled                 = true;
        minimizeanimationEnabled         = true;
      };

      "kwinrc"."Effect-blur" = {
        BlurStrength  = 10;
        NoiseStrength = 2;
      };

      "kwinrc"."Effect-translucency" = {
        Active    = 100;
        Inactive  = 88;
        MoveResize = 80;
        Dialogs   = 100;
        Desktop   = 100;
      };

      "kwinrc"."Compositing" = {
        AnimationSpeed     = 2;
        Backend            = "OpenGL";
        GLPreferBufferSwap = "a";
        OpenGLIsUnsafe     = false;
      };

      "kwinrc"."Windows" = {
        FocusPolicy                = "ClickToFocus";
        RaiseOnClick               = true;
        TitlebarDoubleClickCommand = "MaximizeFull";
      };

      "kwinrc"."Effect-slide".Duration = 300;
    };

    panels = [
      {
        location = "top";
        height = 26;
        screen = 0;
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
        screen = 0;
        alignment = "center";
        lengthMode = "fit";
        floating = true;
        hiding = "dodgewindows";
        widgets = [ "org.kde.plasma.icontasks" ];
      }
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
    noto-fonts
  ];
}
