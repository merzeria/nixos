{ pkgs, ... }:

{
  services.restic.backups.daily = {
    # Replace local path with your Backblaze bucket
    repository = "b2:nixosbackup:simonos-backup";

    # Keep your existing password file
    passwordFile = "/etc/nixos/restic-password";

    # File containing B2_ACCOUNT_ID and B2_ACCOUNT_KEY
    environmentFile = "/etc/nixos/restic-b2-env";

    paths = [
      "/home/simon/simonos"
    ];

    timerConfig = {
      OnCalendar = "02:00";
      Persistent = true;
    };

    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 12"
    ];
  };
}
