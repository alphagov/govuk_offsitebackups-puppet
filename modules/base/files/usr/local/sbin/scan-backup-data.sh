#!/bin/bash
#
# A script to serve /srv/backup-data

echo "Scan of /srv/backup-data started at `date --rfc-3339=s`" >> /var/log/clamav/clamdscan.log
/usr/bin/clamscan --quiet --exclude="/srv/backup-data/lost+found" -l /var/log/clamav/clamscan.log --move /srv/infected /srv/backup-data
