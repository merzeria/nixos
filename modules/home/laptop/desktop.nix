{ ... }:

{
  # Delayed Equibop autostart — small delay to let GNOME settle
  xdg.configFile."autostart/equibop.desktop".text = ''
    [Desktop Entry]
    Name=equibop (Delayed)
    Exec=sh -c "sleep 5 && equibop"
    Type=Application
  '';
}
