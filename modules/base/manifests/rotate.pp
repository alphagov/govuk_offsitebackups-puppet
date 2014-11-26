# rotate.pp
#
# FIXME: Remove class when deployed.
#
class base::rotate {

  file { '/usr/local/sbin/rotate-tarballs.sh':
    ensure => absent,
  }

  cron { 'rotate_old_backups':
    ensure => absent,
    user   => 'govuk-backup',
  }
}
