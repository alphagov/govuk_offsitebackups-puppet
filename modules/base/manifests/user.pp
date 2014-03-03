# == Class: base::user
#
# Create govuk_backup user with group
# Copies ssh_key to authorized_keys
# Jails user to rssh to restrict user's movements to rsync
#
# === Parameters
#
# [*username*]
# Unix account username
#
# [*ssh_key*]
# Public part of SSH key
#

class base::user (
  $username = hiera('base::ssh-username')
  $ssh_key  = hiera('base::ssh-publickey')
  )

  {
    account { $username:
      ssh_key => $ssh_key,
      comment => 'SSH backup user from GOV.UK boxes',
      shell   => '/usr/bin/rssh'
    }
}
