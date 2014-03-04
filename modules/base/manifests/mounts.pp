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

}
