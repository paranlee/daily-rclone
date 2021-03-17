# daily-rclone-backup-batch

This script running on crontab of storage server(SAN storage) on promise environment, observe backup storage status.

repo contains daily sendmail script and rclone batch script. (includes linux, windows)

this script content example of modification files in the last week.

#### setup rclone client

    [root@localhost ~]# crontab -l
    00 1 * * * bash /home/paran/rclone.sh

#### setup daily mail on storage server

    [root@localhost ~]# crontab -l
    30 9 * * * bash /home/paran/sendmail.sh paranlee@paran.lee
    0 9 * * * bash /home/paran/overmail.sh paranlee@paran.lee