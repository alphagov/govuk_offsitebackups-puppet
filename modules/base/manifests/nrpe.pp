# == Class: base::nrpe
#
# This class defines NRPE commands to be used with the pdxcat/nrpe module
# this repository uses.

class base::nrpe{

    nrpe::command {'check_disk':
        ensure  => present,
        command => 'check_disk -w 10% -c 5%',
    }
    nrpe::command {'check_disk_backup-cdn-logs':
        ensure  => present,
        command => 'check_disk -w 10% -c 5% /srv/backup-cdn-logs',
    }
    nrpe::command {'check_disk_backup-logs':
        ensure  => present,
        command => 'check_disk -w 10% -c 5% /srv/backup-logs',
    }
    nrpe::command {'check_disk_backup-data':
        ensure  => present,
        command => 'check_disk -w 10% -c 5% /srv/backup-data',
    }
    nrpe::command {'check_disk_backup-assets':
        ensure  => present,
        command => 'check_disk -w 10% -c 5% /srv/backup-assets',
    }
}
