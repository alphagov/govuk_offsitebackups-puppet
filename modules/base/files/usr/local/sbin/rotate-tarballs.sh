#!/bin/bash

find /srv/backup-data -not \( -path /srv/backup-data/lost+found -prune \) -type f -mtime +30 -exec rm -f {} +
find /srv/backup-graphite -not \( -path /srv/backup-graphite/lost+found -prune \) -type f -mtime +3 -exec rm -f {} +
