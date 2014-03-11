# == Class: base::user
#
# This class creates a `govuk-backup` user for use with base::mounts

class base::user (
  $ssh_key
) {

  account { 'govuk-backup':
    comment      => 'GOV.UK Backup User',
    shell        => '/usr/bin/rssh',
    create_group => true,
    groups       => [],
    ssh_key      => $ssh_key,
  }
}
