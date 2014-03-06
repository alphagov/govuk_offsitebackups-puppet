# == Class: base::clamav
#
# Set up virus scanning of backup-data drive
# After all, we don't want a virus...
#
class base::clamav {

  file { '/usr/local/sbin/scan-backup-data.sh':
    source  =>  'puppet:///modules/base/usr/local/sbin/scan-backup-data.sh',
    owner   =>  'root',
    group   =>  'root',
    mode    =>  '0755',
  }

  cron { 'clamscan-backup-data':
    command =>  '/usr/local/sbin/scan-backup-data.sh',
    minute  =>  fqdn_rand(60),
    require =>  File['/usr/local/sbin/scan-backup-data.sh'],
  }
}
