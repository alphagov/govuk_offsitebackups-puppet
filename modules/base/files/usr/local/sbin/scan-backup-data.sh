#!/bin/bash
#
# A script to scan /srv/backup-data

echo "Scan of /srv/backup-data started at `date --rfc-3339=s`" >> /var/log/clamav/clamdscan.log
/usr/bin/clamdscan --quiet -1 /var/log/clamav/clamdscan.log --move /srv/infected /srv/backup-data
