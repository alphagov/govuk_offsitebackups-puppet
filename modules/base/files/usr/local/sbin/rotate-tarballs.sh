#!/bin/bash

find /srv/backup-data -not \( -path /srv/backup-data/lost+found prune \) -type f -mtime +30 -delete
