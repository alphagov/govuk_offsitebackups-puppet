# == Class: base::mounts
#
# Assuming the VM is not a dev VM, then:
#
# - configure LVM disks
# - mount LVM disks
#
# Always ensure `backup_data` directory exists

class base::mounts {

    file { '/srv/backup-data':
        ensure =>   directory,
        owner  =>   'govuk-backup',
    }

    lvm::volume { 'data':
        ensure  =>  present,
        pv      =>  '/dev/sdb',
        vg      =>  'backup',
        fstype  =>  'ext4',
    }

    ext4mount { '/srv/backup-data':
        mountoptions  =>  'defaults',
        disk          =>  '/dev/mapper/backup-data',
        before        =>  File['/srv/backup-data'],
        require       =>  Lvm::Volume['data'],
    }

    file { '/srv/logs-logs':
        ensure =>   directory,
        owner  =>   'transition-logs-backup',
    }

    lvm::volume { 'logs':
        ensure  =>  present,
        pv      =>  '/dev/sdc',
        vg      =>  'logs',
        fstype  =>  'ext4',
    }

    ext4mount { '/srv/logs-logs':
        mountoptions  =>  'defaults',
        disk          =>  '/dev/mapper/logs-logs',
        before        =>  File['/srv/logs-logs'],
        require       =>  Lvm::Volume['logs'],
    }

    file { '/srv/assets-assets':
        ensure => directory,
        owner  => 'govuk-backup',
    }

    lvm::volume { 'assets':
        ensure => present,
        pv     => '/dev/sdd',
        vg     => 'assets',
        fstype => 'ext4',
    }

    ext4mount { '/srv/assets-assets':
        mountoptions => 'defaults',
        disk         => '/dev/mapper/assets-assets',
        before       => File['/srv/assets-assets'],
        require      => Lvm::Volume['assets'],
    }

}
