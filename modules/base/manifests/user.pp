# == Class: base::user
#
# This class creates backup users for use with base::mounts

class base::user (
  $backup_ssh_key,
  $logs_ssh_key
) {

  account { 'govuk-backup':
    comment      => 'GOV.UK Backup User',
    shell        => '/usr/bin/rssh',
    create_group => true,
    groups       => [],
    ssh_key      => $backup_ssh_key,
  }

  account { 'transition-logs-backup':
    comment      => 'Transition Logs Backup User',
    shell        => '/usr/bin/rssh',
    create_group => true,
    groups       => [],
    ssh_key      => $logs_ssh_key,
  }

  sudo::conf { 'sudo_nopasswd':
    priority     => 10,
    content      => '%sudo ALL=(ALL) NOPASSWD: ALL',
  }

}
