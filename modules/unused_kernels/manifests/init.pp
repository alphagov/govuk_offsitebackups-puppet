# Class: unused_kernels
#
# Periodically remove packages for Ubuntu kernels that are no longer used in
# order to reclaim disk space used.
#
class unused_kernels {

  package { 'ubuntu_unused_kernels':
    ensure   => '0.2.0',
    provider => 'gem',
  } ->
  file { '/etc/cron.daily/remove_unused_kernels.sh':
    ensure => present,
    source => 'puppet:///modules/unused_kernels/etc/cron.daily/remove_unused_kernels.sh',
    mode   => '0755',
  }

}
