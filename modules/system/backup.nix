{ pkgs, ... }:

{
  services.restic.backups.daily = {
    # Where to save the backup. Change this to your backup drive path!
    repository = "/mnt/games/nixbackup/";

    # Password file so it can run automatically (create this file manually)
    passwordFile = "/etc/nixos/restic-password";

    # What to back up
    paths = [
      "/home/simon/simonos"
    ];

    # When to run (Daily at 2 AM)
    timerConfig = {
      OnCalendar = "02:00";
      Persistent = true; # Run immediately if the PC was off at 2 AM
    };

    # Keep only the last 7 daily, 4 weekly, and 12 monthly backups
    pruneOpts = [
      "--keep-daily 7"
      "--keep-weekly 4"
      "--keep-monthly 12"
    ];
  };
}
