# rotate.pp
#
# This file defines the cron type and options in order to ensure that
# backed-up data held on /srv/backup-data on off-site backup machines
# is removed after thirty days.

class base::rotate {
  cron { 'rotate_old_backups':
    command => 'find /srv/backup-data -not \( -path /srv/backup-data/lost+found prune \) -type f -mtime +30 -delete',
    user    => 'govuk-backup',
    hour    => 09,
    minute  => 00,
  }
}
