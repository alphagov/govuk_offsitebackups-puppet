# == Class: base::ufw
#
# Configures ufw
#
class base::ufw {

  ufw::allow { 'allow-ssh':
    port => '22',
    ip   => 'any'
  }

}
