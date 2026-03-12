{ pkgs, lib, ... }:

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
      "konsolerc"."Desktop Entry"."DefaultProfile" = "simon.profile";
      "kwinrc"."Plugins" = {
        blurEnabled              = true;
        translucencyEnabled      = true;
        slidebackEnabled         = true;
        minimizeanimationEnabled = true;
      };
      "kwinrc"."Effect-blur" = {
        BlurStrength  = 10;
        NoiseStrength = 2;
      };
      "kwinrc"."Effect-translucency" = {
        Active     = 100;
        Inactive   = 88;
        MoveResize = 80;
        Dialogs    = 100;
        Desktop    = 100;
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

  xdg.dataFile."konsole/Sweet.colorscheme" = {
    force = true;
    text = ''
      [General]
      Description=Sweet
      Opacity=0.85
      Wallpaper=

      [Background]
      Color=#1e1d2f
      [BackgroundIntense]
      Color=#2a2a3d

      [Foreground]
      Color=#e0def4
      [ForegroundIntense]
      Color=#ffffff

      [Color0]
      Color=#1e1d2f
      [Color0Intense]
      Color=#3b3a52

      [Color1]
      Color=#f05e97
      [Color1Intense]
      Color=#f07da8

      [Color2]
      Color=#5eff6c
      [Color2Intense]
      Color=#80ff8c

      [Color3]
      Color=#f3c173
      [Color3Intense]
      Color=#f5ce8e

      [Color4]
      Color=#7e9ef5
      [Color4Intense]
      Color=#9ab0f5

      [Color5]
      Color=#b072d1
      [Color5Intense]
      Color=#c084e0

      [Color6]
      Color=#70e6d0
      [Color6Intense]
      Color=#8aeedd

      [Color7]
      Color=#e0def4
      [Color7Intense]
      Color=#ffffff
    '';
  };

  home.activation.konsoleProfile = lib.hm.dag.entryAfter ["writeBoundary"] ''
    printf '[Appearance]\nColorScheme=Sweet\nFont=JetBrainsMono Nerd Font,10,-1,5,50,0,0,0,0,0\n\n[General]\nName=simon\nParent=FALLBACK/\n' \
      > "$HOME/.local/share/konsole/simon.profile"
  '';

  home.packages = with pkgs; [
    sweet-nova
    sweet
    candy-icons
    noto-fonts
  ];
}
