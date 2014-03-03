# This file controls the packages installed on destination machines.
# It can be easily updated by adding new package names to the array.

class base::packages {

  package {
    [
      'ack-grep',
      'bzip2',
      'tar',
    ]
    ensure => installed;
  }
}
