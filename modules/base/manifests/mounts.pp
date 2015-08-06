# == Class: base::mounts
#
# Assuming the VM is not a dev VM, then:
#
# - configure LVM disks
# - mount LVM disks
#
# Always ensure `backup_data` directory exists

class base::mounts(
  $assets_disks,
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

    # lvm::volume { 'assets':
    $assets_vgname = 'assetsbackup'
    $assets_lvname = 'assets'
    physical_volume { $assets_disks:
        ensure => present,
    }
    volume_group { $assets_vgname:
        ensure           => present,
        physical_volumes => $assets_disks,
        require          => Physical_volume[${assets_disks}],
    }
    logical_volume { $assets_lvname:
        ensure       => present,
        volume_group => $assets_vgname,
        require      => Volume_group[$assets_vgname],
    }
    filesystem { "/dev/${assets_vgname}/${assets_lvname}":
        ensure  => present,
        fs_type => 'ext4',
        require => Logical_volume[$assets_lvname]
    }
    ext4mount { '/srv/backup-assets':
        mountoptions => 'defaults',
        disk         => "/dev/mapper/${assets_vgname}-${assets_lvname}",
        before       => File['/srv/backup-assets'],
        require      => Filesystem["/dev/${assets_vgname}/${assets_lvname}"],
    }
    # } end lvm::volume

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
