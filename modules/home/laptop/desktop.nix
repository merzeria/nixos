{ ... }:

{
  # Delayed Equibop autostart — small delay to let GNOME settle
  xdg.configFile."autostart/equibop.desktop".text = ''
    [Desktop Entry]
    Name=equibop
    Exec=sh -c "equibop"
    Type=Application
  '';
}
