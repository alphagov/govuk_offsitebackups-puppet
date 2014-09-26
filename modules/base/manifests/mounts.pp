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

    file { '/srv/logs-backup':
        ensure =>   directory,
        owner  =>   'transition-logs-backup',
    }

    lvm::volume { 'backup':
        ensure  =>  present,
        pv      =>  '/dev/sdc',
        vg      =>  'logs',
        fstype  =>  'ext4',
    }

    ext4mount { '/srv/logs-backup':
        mountoptions  =>  'defaults',
        disk          =>  '/dev/mapper/logs-backup',
        before        =>  File['/srv/logs-backup'],
        require       =>  Lvm::Volume['backup'],
    }

    file { '/srv/backup-assets':
        ensure  => directory,
        owner   => 'govuk-assets',
    }

    file { '/srv/backup-assets/whitehall':
        ensure  => directory,
        owner   => 'govuk-assets',
        group   => 'govuk-assets',
    }

    file { '/srv/backup-assets/asset-manager':
        ensure  => directory,
        owner   => 'govuk-assets',
        group   => 'govuk-assets',
    }

    lvm::volume { 'assets':
        ensure  => present,
        pv      => '/dev/sdd',
        vg      => 'assetsbackup',
        fstype  => 'ext4',
    }

    ext4mount { '/srv/backup-assets':
        mountoptions  => 'defaults',
        disk          => '/dev/mapper/assetsbackup-assets',
        before        => File['/srv/backup-assets'],
        require       => Lvm::Volume['assets'],
    }
}
