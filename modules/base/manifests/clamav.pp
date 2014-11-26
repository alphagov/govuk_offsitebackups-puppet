# == Class: base::clamav
#
# FIXME: Remove this class once deployed.
#
class base::clamav {

  service { ['clamav-freshclam', 'clamav-daemon']:
    ensure   => stopped,
    provider => base,
  } ->
  package { ['clamav', 'clamav-base', 'clamav-freshclam', 'clamav-daemon']:
    ensure => purged,
  } ->
  file { ['/etc/clamav/clamd.conf', '/etc/clamav/freshclam.conf']:
    ensure => absent,
  }

  file { '/srv/infected':
    ensure => absent,
    force  => true,
  }

  file { '/usr/local/sbin/scan-backup-data.sh':
    ensure  => absent,
  }

  file { '/etc/logrotate.d/clamdscan':
    ensure  => absent,
  }

  cron { 'clamscan-backup-data':
    ensure  => absent,
    command => '/usr/local/sbin/scan-backup-data.sh',
    minute  => fqdn_rand(60),
  }
}
