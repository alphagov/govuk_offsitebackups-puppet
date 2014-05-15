# == Class: base::nrpe
#
# This class defines NRPE commands to be used with the pdxcat/nrpe module
# this repository uses.

class base::nrpe{

    nrpe::command {'check_disk':
        ensure  => present,
        command => 'check_disk -w 20% -c 10% /srv/backup-data',
    }
}
