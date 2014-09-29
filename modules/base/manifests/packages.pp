# packages.pp
#
# This file ensures that certain packages passed in an array are installed.
# The packages installed are kept intentionally light.

class base::packages {
  package {
    [
        'ack-grep',
        'bzip2',
        'tar',
        'update-notifier-common',
    ]:
    ensure => installed,
  }
}
