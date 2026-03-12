{ config, lib, pkgs, inputs, ... }: {
  imports = [ inputs.noctalia.homeModules.default ];

  programs.waybar.enable = lib.mkForce false;

  home.packages = [ inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default ];

  home.file.".config/noctalia/settings.json.template".text = builtins.toJSON {
    appLauncher = {
      backgroundOpacity  = 1;
      enableClipboardHistory = false;
      pinnedExecs        = [];
      position           = "center";
      sortByMostUsed     = true;
      terminalCommand    = "kitty -e";
      useApp2Unit        = false;
    };
    audio = {
      cavaFrameRate    = 60;
      mprisBlacklist   = [];
      preferredPlayer  = "";
      visualizerType   = "linear";
      volumeOverdrive  = false;
      volumeStep       = 5;
    };
    bar = {
      backgroundOpacity = 1;
      density           = "default";
      floating          = false;
      marginHorizontal  = 0.25;
      marginVertical    = 0.25;
      monitors          = [];
      position          = "top";
      showCapsule       = true;
      widgets = {
        center = [
          {
            id               = "Clock";
            customFont       = "";
            formatHorizontal = "HH:mm, dddd dd MMM";
            formatVertical   = "HH mm - dd MM";
            useCustomFont    = false;
            usePrimaryColor  = true;
          }
        ];
        left = [
          {
            id              = "Workspace";
            hideUnoccupied  = false;
            labelMode       = "index";
          }
          {
            id            = "ActiveWindow";
            colorizeIcons = false;
            hideMode      = "hidden";
            maxWidth      = 145;
            scrollingMode = "hover";
            showIcon      = true;
            useFixedWidth = false;
          }
          {
            id            = "MediaMini";
            hideMode      = "hidden";
            maxWidth      = 145;
            scrollingMode = "hover";
            showAlbumArt  = false;
            showVisualizer = false;
            useFixedWidth = false;
            visualizerType = "linear";
          }
        ];
        right = [
          {
            id            = "Tray";
            blacklist     = [];
            colorizeIcons = false;
          }
          {
            id                  = "SystemMonitor";
            showCpuTemp         = true;
            showCpuUsage        = true;
            showDiskUsage       = false;
            showMemoryAsPercent = false;
            showMemoryUsage     = true;
            showNetworkStats    = false;
          }
          {
            id               = "NotificationHistory";
            hideWhenZero     = true;
            showUnreadBadge  = true;
          }
          {
            id          = "Volume";
            displayMode = "onhover";
          }
          {
   	id = "Battery";
    	showPercentage = true;
  	}
          {
            id             = "ControlCenter";
            icon           = "noctalia";
            useDistroLogo  = false;
            customIconPath = "";
          }
        ];
      };
    };
    battery.chargingMode = 0;
    brightness.brightnessStep = 5;
    colorSchemes = {
      darkMode                    = true;
      generateTemplatesForPredefined = true;
      manualSunrise               = "06:30";
      manualSunset                = "18:30";
      matugenSchemeType           = "scheme-fruit-salad";
      predefinedScheme            = "Eldritch";
      schedulingMode              = "off";
      useWallpaperColors          = false;
    };
    general = {
      animationDisabled     = false;
      animationSpeed        = 1;
      avatarImage           = "";
      compactLockScreen     = false;
      dimDesktop            = true;
      forceBlackScreenCorners = false;
      language              = "en";
      lockOnSuspend         = true;
      radiusRatio           = 0.5;
      scaleRatio            = 1;
      screenRadiusRatio     = 1;
      showScreenCorners     = false;
    };
    location = {
      name                       = "Copenhagen";
      showCalendarEvents         = true;
      showWeekNumberInCalendar   = true;
      use12hourFormat            = false;
      useFahrenheit              = false;
      weatherEnabled             = true;
    };
    notifications = {
      criticalUrgencyDuration  = 15;
      doNotDisturb             = false;
      location                 = "top_right";
      lowUrgencyDuration       = 3;
      monitors                 = [];
      normalUrgencyDuration    = 8;
      overlayLayer             = true;
      respectExpireTimeout     = false;
    };
    osd = {
      autoHideMs   = 2000;
      enabled      = true;
      location     = "top_right";
      monitors     = [];
      overlayLayer = true;
    };
    ui = {
      fontDefault      = "JetBrainsMono Nerd Font";
      fontDefaultScale = 1;
      fontFixed        = "JetBrainsMono Nerd Font Mono";
      fontFixedScale   = 1;
      panelsOverlayLayer = true;
      tooltipsEnabled  = true;
    };
    wallpaper = {
      defaultWallpaper          = "";
      directory                 = "";
      enabled                   = true;
      fillColor                 = "#1e1e2e";
      fillMode                  = "crop";
      monitors                  = [];
      randomEnabled             = false;
      randomIntervalSec         = 300;
      setWallpaperOnAllMonitors = true;
      transitionDuration        = 1500;
      transitionType            = "random";
    };
    settingsVersion  = 16;
    setupCompleted   = true;
  };

  home.activation.noctaliaSettingsInit = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    SETTINGS_FILE="$HOME/.config/noctalia/settings.json"
    TEMPLATE_FILE="$HOME/.config/noctalia/settings.json.template"
    if [ ! -f "$SETTINGS_FILE" ] || [ -L "$SETTINGS_FILE" ]; then
      $DRY_RUN_CMD rm -f "$SETTINGS_FILE"
      $DRY_RUN_CMD cp "$TEMPLATE_FILE" "$SETTINGS_FILE"
      $DRY_RUN_CMD chmod 644 "$SETTINGS_FILE"
    fi
  '';
}
