{ config, pkgs, lib, ... }:

let
  # All the mutable config files (scripts, QML, etc.) live here.
  # Clone/copy the `config/` folder from the forked repo to this location.
  extCfg = "/home/simon/simonos/external/hyprland";
in
{
  imports = [
    ../../common
  ];

  # ── Hyprland ──────────────────────────────────────────────────────────────
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.settings = {
    general = {
      border_size         = 0;
      gaps_in             = 4;
      gaps_out            = 4;
      resize_on_border    = true;
      extend_border_grab_area = 30;
    };
    decoration = {
      rounding        = 4;
      active_opacity  = 1.0;
      inactive_opacity = 1.0;
      blur.enabled    = false;
      shadow.enabled  = false;
    };
    input = {
      kb_layout  = "dk";
      kb_variant = "";
      kb_model   = "";
      kb_rules   = "";
      touchpad = {
        natural_scroll = true;
        tap            = true;
      };
      accel_profile = "flat";
    };
    misc = {
      font_family             = "JetBrains Mono";
      disable_hyprland_logo   = true;
      disable_splash_rendering = true;
      focus_on_activate       = true;
    };
    monitor = [
      "eDP-1, 1920x1080@60, 0x0, 1.0"
    ];
  };

  # ── Autostart ─────────────────────────────────────────────────────────────
  wayland.windowManager.hyprland.settings."exec-once" = [
    "swww-daemon"
    "hypridle"
    "playerctld"
    "wl-paste --type text --watch cliphist store"
    "wl-paste --type image --watch cliphist store"
    "swayosd-server"
    "${extCfg}/config/sessions/hyprland/scripts/volume_listener.sh"
    "quickshell -p ${extCfg}/config/sessions/hyprland/scripts/quickshell/Main.qml"
    "quickshell -p ${extCfg}/config/sessions/hyprland/scripts/quickshell/TopBar.qml"
    "python3 ${extCfg}/config/sessions/hyprland/scripts/quickshell/focustime/focus_daemon.py &"
  ];

  # ── Binds ─────────────────────────────────────────────────────────────────
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindl = [
      ", XF86AudioMute,         exec, swayosd-client --output-volume mute-toggle"
      ", XF86AudioPlay,         exec, playerctl play-pause"
      ", XF86AudioPause,        exec, playerctl play-pause"
      ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
      ", XF86MonBrightnessUp,   exec, swayosd-client --brightness raise"
      ", Print,                 exec, ${extCfg}/config/sessions/hyprland/scripts/screenshot.sh"
      "SHIFT_L, Print,          exec, ${extCfg}/config/sessions/hyprland/scripts/screenshot.sh --edit"
      ", XF86PowerOff,          exec, hyprlock"
    ];

    bindel = [
      ", xf86audiolowervolume, exec, swayosd-client --output-volume lower"
      ", xf86audioraisevolume, exec, swayosd-client --output-volume raise"
      "$mainMod, L, exec, hyprlock"
    ];

    bind = [
      "$mainMod, D,          exec, rofi -show drun -config ${extCfg}/config/programs/rofi/config.rasi"
      "ALT, TAB,             exec, rofi -show window -config ${extCfg}/config/programs/rofi/config.rasi"
      "$mainMod, C,          exec, bash ${extCfg}/config/sessions/hyprland/scripts/rofi_clipboard.sh"
      "$mainMod, A,          exec, swaync-client -t -sw"
      "$mainMod, RETURN,     exec, $terminal"
      "$mainMod, T,          exec, $terminal"
      "$mainMod, Q,          exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh toggle music"
      "$mainMod, W,          exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh toggle wallpaper"
      "$mainMod, S,          exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh toggle calendar"
      "$mainMod, N,          exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh toggle network"
      "$mainMod, B,          exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh toggle battery"
      "$mainMod&SHIFT_L, T,  exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh toggle focustime"
      "$mainMod&SHIFT_L, F,  togglefloating,"
      "$mainMod&SHIFT_L, Q,  killactive,"

      "$mainMod, left,        movefocus, l"
      "$mainMod, right,       movefocus, r"
      "$mainMod, up,          movefocus, u"
      "$mainMod, down,        movefocus, d"
      "$mainMod, H,           movefocus, l"
      "$mainMod, J,           movefocus, d"
      "$mainMod, K,           movefocus, u"
      "$mainMod, L,           movefocus, r"

      "$mainMod&CTRL, left,   movewindow, l"
      "$mainMod&CTRL, right,  movewindow, r"
      "$mainMod&CTRL, up,     movewindow, u"
      "$mainMod&CTRL, down,   movewindow, d"

      "$mainMod, F,           fullscreen, 0"

      "$mainMod, 1, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 1"
      "$mainMod, 2, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 2"
      "$mainMod, 3, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 3"
      "$mainMod, 4, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 4"
      "$mainMod, 5, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 5"
      "$mainMod, 6, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 6"
      "$mainMod, 7, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 7"
      "$mainMod, 8, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 8"
      "$mainMod, 9, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 9"

      "$mainMod SHIFT, 1, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 1 move"
      "$mainMod SHIFT, 2, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 2 move"
      "$mainMod SHIFT, 3, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 3 move"
      "$mainMod SHIFT, 4, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 4 move"
      "$mainMod SHIFT, 5, exec, bash ${extCfg}/config/sessions/hyprland/scripts/qs_manager.sh 5 move"

      "Print,          exec, ${extCfg}/config/sessions/hyprland/scripts/screenshot.sh"
      "Mod+Shift+S,    exec, ${extCfg}/config/sessions/hyprland/scripts/screenshot.sh"
    ];
  };

  # ── Animations ────────────────────────────────────────────────────────────
  wayland.windowManager.hyprland.settings.animations = {
    enabled = true;
    bezier = [ "myBezier, 0.05, 0.9, 0.1, 1.05" ];
    animation = [
      "windows, 1, 5, myBezier, popin 80%"
      "windowsOut, 1, 5, myBezier, popin 80%"
      "layers, 1, 5, myBezier, fade"
      "fade, 1, 5, myBezier"
      "workspaces, 1, 5, myBezier, slide"
    ];
  };

  # ── Window rules ──────────────────────────────────────────────────────────
  wayland.windowManager.hyprland.settings.windowrulev2 = [
    "float, title:^(qs-master)$"
    "pin, title:^(qs-master)$"
    "noshadow, title:^(qs-master)$"
    "noborder, title:^(qs-master)$"
    "move -5000 -5000, title:^(qs-master)$"
    "noinitialfocus, title:^(qs-master)$"
  ];

  # ── Hyprlock ──────────────────────────────────────────────────────────────
  xdg.configFile."hypr/hyprlock.conf".source =
    config.lib.file.mkOutOfStoreSymlink
      "${extCfg}/config/sessions/hyprland/hyprlock/hyprlock.conf";

  xdg.configFile."hypr/hyprlock".source =
    config.lib.file.mkOutOfStoreSymlink
      "${extCfg}/config/sessions/hyprland/hyprlock/scripts";

  # ── Hypridle ──────────────────────────────────────────────────────────────
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd         = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
      };
      listener = [{
        timeout    = 600;
        on-timeout = "systemctl suspend";
      }];
    };
  };

  # ── Quickshell scripts (mutable, symlinked out of store) ──────────────────
  home.file.".config/hypr/scripts".source =
    config.lib.file.mkOutOfStoreSymlink
      "${extCfg}/config/sessions/hyprland/scripts";

  # ── Rofi (symlinked so the rasi files stay editable) ──────────────────────
  xdg.configFile."rofi".source =
    config.lib.file.mkOutOfStoreSymlink
      "${extCfg}/config/programs/rofi";

  # ── Swaync ────────────────────────────────────────────────────────────────
  xdg.configFile."swaync".source =
    config.lib.file.mkOutOfStoreSymlink
      "${extCfg}/config/programs/swaync";

  # ── SwayOSD ───────────────────────────────────────────────────────────────
  services.swayosd = {
    enable      = true;
    topMargin   = 0.9;
    stylePath   = "${extCfg}/config/programs/swayosd/style.css";
  };

  # ── Matugen (wallpaper → color templates) ────────────────────────────────
  xdg.configFile."matugen".source =
    config.lib.file.mkOutOfStoreSymlink
      "${extCfg}/config/programs/matugen";

  # ── Extra packages ────────────────────────────────────────────────────────
  home.packages = with pkgs; [
    kitty
    rofi
    fd
    ripgrep
    fortune
    alsa-utils
    hyprshot
    gtk3
    hyprlock
    easyeffects
    jq
    imagemagick
    libnotify
    networkmanager
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
