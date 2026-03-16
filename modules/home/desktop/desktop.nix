{ ... }:

{

  # Delayed autostart — gives Plasma time to settle before launching Electron apps
  xdg.configFile = {
    "autostart/steam.desktop".text = ''
      [Desktop Entry]
      Name=Steam
      Exec=sh -c "sleep 10 && steam -silent %U"
      Type=Application
    '';
    "autostart/equibop.desktop".text = ''
      [Desktop Entry]
      Name=equibop (Delayed)
      Exec=sh -c "sleep 10 && equibop"
      Type=Application
    '';
  };
}
