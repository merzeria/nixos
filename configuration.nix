{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ./modules/system/desktop.nix ];

  # This is the ONLY thing needed to allow you to use your flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # --- KDE Overlay to fix stutters ---
  nixpkgs.overlays = [
    (final: prev: {
      kdePackages = prev.kdePackages.overrideScope (
        kdeFinal: kdePrev: {
          plasma-workspace = let
            basePkg = kdePrev.plasma-workspace;
            xdgdataPkg = final.stdenv.mkDerivation {
              name = "${basePkg.name}-xdgdata";
              buildInputs = [ basePkg ];
              dontUnpack = true;
              dontFixup = true;
              dontWrapQtApps = true;
              installPhase = ''
                mkdir -p $out/share
                ( IFS=:
                  for DIR in $XDG_DATA_DIRS; do
                    if [[ -d "$DIR" ]]; then
                      cp -r $DIR/. $out/share/
                      chmod -R u+w $out/share
                    fi
                  done
                )
              '';
            };
          in basePkg.overrideAttrs (old: {
            preFixup = (old.preFixup or "") + ''
              for index in "''${!qtWrapperArgs[@]}"; do
                if [[ ''${qtWrapperArgs[$((index+0))]} == "--prefix" ]] && [[ ''${qtWrapperArgs[$((index+1))]} == "XDG_DATA_DIRS" ]]; then
                  unset -v "qtWrapperArgs[$((index+0))]"
                  unset -v "qtWrapperArgs[$((index+1))]"
                  unset -v "qtWrapperArgs[$((index+2))]"
                  unset -v "qtWrapperArgs[$((index+3))]"
                fi
              done
              qtWrapperArgs=("''${qtWrapperArgs[@]}")
              qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "${xdgdataPkg}/share")
              qtWrapperArgs+=(--prefix XDG_DATA_DIRS : "$out/share")
            '';
          });
        }
      );
    })
  ];

  # All other logic should be in ~/simonos/
  system.stateVersion = "25.11";
}
