{ pkgs, lib, ... }:
{
  services.xserver.enable              = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable              = true;

 services.displayManager = {
  sddm = {
    enable         = true;
    wayland.enable = true;
  settings.Autologin.Session ="plasma";
  };
  autoLogin = {
    enable = true;
    user   = "simon";
  };
};

  qt = {
    enable        = true;
    platformTheme = "kde";
    style         = "kvantum";
  };

  environment.systemPackages = with pkgs; [
  kdePackages.qtstyleplugin-kvantum
  catppuccin-cursors.mochaMauve    # add this
  (catppuccin-kde.override         { flavour = ["mocha"]; accents = ["mauve"]; winDecStyles = ["classic"]; })
  (catppuccin-papirus-folders.override { flavor = "mocha"; accent = "mauve"; })
  (catppuccin-kvantum.override     { variant = "mocha"; accent = "mauve"; })
];
environment.sessionVariables = {
  QML2_IMPORT_PATH = lib.makeSearchPath "lib/qt-6/qml" (with pkgs; [
    kdePackages.kirigami
    kdePackages.libplasma
  ]);
};
# Disable Gnome keyring:
  services.gnome.gnome-keyring.enable = false;
}
