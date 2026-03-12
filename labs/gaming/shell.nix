{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  name = "gaming-lab";
  # Packages to be available in the shell
  buildInputs = with pkgs; [
    # Performance Monitoring
    goverlay      # GUI for configuring MangoHud
    nvtopPackages.nvidia # GPU process monitor (Top-like)
    #amdgpu_top    # Just in case you ever swap or have an iGPU

    # Game Capture & Recording
    #obs-studio
    gpu-screen-recorder # Low overhead recording for NVIDIA

    # Utilities
    gamescope     # Micro-compositor for better game scaling/HDR
    winetricks    # Essential for fixing broken Windows dependencies
    protontricks  # Winetricks specifically for Steam Proton

    # Fun/Social
    #discord-canary # Faster updates for experimental features
  ];

  # Commands to run when entering the shell
  shellHook = ''
    echo "--- 🎮 Gaming Lab Activated ---"
    echo "NVIDIA Status:"
    nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu --format=csv,noheader
    echo "-------------------------------"
    echo "Tip: Use 'nvtop' to see GPU usage or 'goverlay' to tune your HUD."
  '';

  # Environment variables for this session
  env = {
    MANGOHUD = "1"; # Force MangoHud on for anything launched here
    GAMEMODERUN = "1"; # Request GameMode for launched apps
  };
}
