{ ... }:

{
  xdg.configFile."autostart/equibop.desktop".text = ''
    [Desktop Entry]
    Name=equibop
    Exec=sh -c "equibop"
    Type=Application
  '';
}
