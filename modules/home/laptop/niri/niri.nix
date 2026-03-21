{ pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    kitty
    wl-clipboard
  ];

  xdg.configFile."niri/config.kdl".text = ''
    input {
        keyboard {
            xkb {
                layout "dk"
            }
        }
        touchpad {
            natural-scroll
            tap
        }
        mouse {
            accel-profile "adaptive"
        }
        focus-follows-mouse
        warp-mouse-to-focus
    }

    output "eDP-1" {
        mode "1920x1080@60.000"
        scale 1.0
        position x=0 y=0
    }

    layout {
        gaps 4
        preset-column-widths {
            proportion 0.5
            proportion 0.667
            proportion 1.0
        }

        default-column-width { proportion 0.5; }

        border {
            width 2
            active-color   "#cba6f7"
            inactive-color "#45475a"
            urgent-color   "#f38ba8"
        }

        focus-ring { 
        off
        }

        shadow {
            on
            softness 20
            spread   4
            offset x=0 y=4
            color "#00000055"
        }
    }

    animations {
        workspace-switch {
            spring damping-ratio=0.85 stiffness=500 epsilon=0.0001
        }
        window-open {
            duration-ms 150
            curve "ease-out-expo"
        }
        window-close {
            duration-ms 120
            curve "ease-out-quad"
        }
        horizontal-view-movement {
            spring damping-ratio=0.85 stiffness=420 epsilon=0.0001
        }
        window-movement {
            spring damping-ratio=0.75 stiffness=320 epsilon=0.0001
        }
        window-resize {
            spring damping-ratio=0.85 stiffness=420 epsilon=0.0001
        }
    }

    spawn-at-startup "noctalia-shell"
    spawn-at-startup "swww-daemon"
    spawn-at-startup "xwayland-satellite"

    environment {
    XDG_CURRENT_DESKTOP "niri"
    MOZ_ENABLE_WAYLAND  "1"
    QT_QPA_PLATFORM     "wayland"
    ELECTRON_OZONE_PLATFORM_HINT "wayland"
    GTK_USE_PORTAL "1"
    QML2_IMPORT_PATH "${pkgs.kdePackages.kirigami}/lib/qt-6/qml:${pkgs.kdePackages.libplasma}/lib/qt-6/qml"
}

    prefer-no-csd
    hotkey-overlay { 
    skip-at-startup 
    }

    screenshot-path "~/Pictures/Screenshots/Screenshot %Y-%m-%d %H-%M-%S.png"

    binds {
        // Applications
        Mod+Return { spawn "kitty"; }
        Mod+T      { spawn "kitty"; }
        Mod+Space  { spawn "rofi" "-show" "drun"; }
        Mod+B      { spawn "brave"; }
        Mod+V      { spawn "pwvucontrol"; }

        // Overview / hotkey help
        Mod+O               { toggle-overview; }
        Mod+Z     { show-hotkey-overlay; }

        // Window management
        Mod+Q         { close-window; }
        Mod+F         { maximize-column; }
        Mod+Shift+F   { fullscreen-window; }
        Mod+W         { toggle-window-floating; }
        Mod+Ctrl+W    { switch-focus-between-floating-and-tiling; }

        // Focus (vim + arrows)
        Mod+H     { focus-column-left; }
        Mod+J     { focus-window-down; }
        Mod+K     { focus-window-up; }
        Mod+L     { focus-column-right; }
        Mod+Left  { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Right { focus-column-right; }

        // Move windows
        Mod+Shift+H     { move-column-left; }
        Mod+Shift+J     { move-window-down; }
        Mod+Shift+K     { move-window-up; }
        Mod+Shift+L     { move-column-right; }
        Mod+Shift+Left  { move-column-left; }
        Mod+Shift+Down  { move-window-down; }
        Mod+Shift+Up    { move-window-up; }
        Mod+Shift+Right { move-column-right; }

        // Column width
        Mod+R         { switch-preset-column-width; }
        Mod+Shift+R   { switch-preset-window-height; }
        Mod+Minus     { set-column-width "-10%"; }
        Mod+Plus     { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Plus { set-window-height "+10%"; }
        Mod+Ctrl+F    { expand-column-to-available-width; }
        Mod+Ctrl+C    { center-column; }

        // Consume / expel into columns
        Mod+M  { consume-or-expel-window-left; }
        Mod+N { consume-or-expel-window-right; }

        // Workspaces
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }
        Mod+U          { focus-workspace-down; }
        Mod+I          { focus-workspace-up; }
        Mod+Ctrl+Down  { focus-workspace-down; }
        Mod+Ctrl+Up    { focus-workspace-up; }
        Mod+Shift+U    { move-column-to-workspace-down; }
        Mod+Shift+I    { move-column-to-workspace-up; }

        Mod+WheelScrollDown cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp   cooldown-ms=150 { focus-workspace-up; }

        // Screenshots
        Print       { screenshot; }
        Mod+Shift+S { screenshot; }
        Ctrl+Print  { screenshot-screen; }
        Alt+Print   { screenshot-window; }

        // Lock
        Mod+Ctrl+L { spawn "swaylock"; }

        // Media / hardware keys
        XF86AudioRaiseVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
        XF86AudioLowerVolume  allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
        XF86AudioMute         allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86MonBrightnessUp   allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%+"; }
	XF86MonBrightnessDown allow-when-locked=true { spawn "${pkgs.brightnessctl}/bin/brightnessctl" "set" "5%-"; }

        // Quit
        Mod+Shift+Q { quit; }
        Mod+Alt+P   { power-off-monitors; }
    }

    window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
        draw-border-with-background false
    }

    window-rule {
        match app-id=r#"^(kitty|floorp|pwvucontrol|equibop)$"#
        opacity 0.95
    }

    window-rule {
        match app-id=r#"^org\.wezfurlong\.wezterm$"#
        default-column-width {}
    }
  '';

}
