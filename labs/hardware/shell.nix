{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  name = "hardware-hacking";

  buildInputs = with pkgs; [
    brave         # The engine needed for the Keychron web editor
    usbutils      # Provides 'lsusb' to see if the board is detected
    evtest        # To see raw keyboard signals
    hidapi        # Tools for interacting with HID devices
  ];

  shellHook = ''
    echo "--- ⌨️ Keychron Config Lab ---"
    echo "1. Open Brave: 'brave'"
    echo "2. Go to: https://launcher.keychron.com/"
    echo "3. Ensure your keyboard is plugged in."
    echo "------------------------------"
    lsusb | grep -i "Keychron" || echo "Warning: Keychron not detected in USB list."
  '';
}
