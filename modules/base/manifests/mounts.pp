# == Class: base::mounts
#
# Assuming the VM is not a dev VM, then:
#
# - configure LVM disks
# - mount LVM disks
#
# Always ensure `backup_data` directory exists

class base::mounts(
  $assets_disks
){

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

    file { '/srv/backup-logs':
        ensure =>   directory,
        owner  =>   'transition-logs-backup',
    }

    lvm::volume { 'backup':
        ensure  =>  present,
        pv      =>  '/dev/sdc',
        vg      =>  'logsbackup',
        fstype  =>  'ext4',
    }

    ext4mount { '/srv/backup-logs':
        mountoptions  =>  'defaults',
        disk          =>  '/dev/mapper/logsbackup-backup',
        before        =>  File['/srv/backup-logs'],
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

    file { '/srv/backup-assets':
        ensure  => directory,
        owner   => 'govuk-backup',
        group   => 'govuk-backup',
    }

    lvm::volume { 'assets':
        ensure  => present,
        pv      => $assets_disks,
        vg      => 'assetsbackup',
        fstype  => 'ext4',
    }

    ext4mount { '/srv/backup-assets':
        mountoptions  => defaults,
        disk          => '/dev/mapper/assetsbackup-assets',
        before        => File ['/srv/backup-assets'],
        require       => Lvm::Volume['graphite'],
    }

    file { '/srv/backup-graphite':
        ensure  => directory,
        owner   => 'govuk-backup',
        group   => 'govuk-backup',
    }

    lvm::volume { 'graphite':
        ensure  => present,
        pv      => '/dev/sde',
        vg      => 'graphitebackup',
        fstype  => 'ext4',
    }

    ext4mount { '/srv/backup-graphite':
        mountoptions  => 'defaults',
        disk          => '/dev/mapper/graphitebackup-graphite',
        before        => File['/srv/backup-graphite'],
        require       => Lvm::Volume['graphite'],
    }

    file { '/srv/backup-graphite/tarballs':
        ensure  => directory,
        owner   => 'govuk-backup',
        group   => 'govuk-backup',
        require => Ext4mount['/srv/backup-graphite'],
    }
}
