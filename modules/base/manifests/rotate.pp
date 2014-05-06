# rotate.pp
#
# This file defines the cron type and options in order to ensure that
# backed-up data held on /srv/backup-data on off-site backup machines
# is removed after thirty days.

class base::rotate {
  cron { 'rotate_old_backups':
    command => './usr/sbin/rotate-tarballs.sh',
    user    => 'govuk-backup',
    hour    => 09,
    minute  => 00,
  }
}
