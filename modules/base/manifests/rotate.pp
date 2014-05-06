# rotate.pp
#
# This file defines the cron type and options in order to ensure that
# backed-up data held on /srv/backup-data on off-site backup machines
# is removed after thirty days.

class base::rotate {

  file { '/usr/local/sbin/rotate-tarballs.sh':
    source  => 'puppet:///modules/base/usr/local/sbin/rotate-tarballs.sh',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  cron { 'rotate_old_backups':
    require => File['/usr/local/sbin/rotate-tarballs.sh'],
    command => '/usr/local/sbin/rotate-tarballs.sh',
    user    => 'govuk-backup',
    hour    => 09,
    minute  => 00,
  }
}
