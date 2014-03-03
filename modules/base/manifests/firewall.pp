# == Class: base firewall
#
# Configures ufw, allowing port 22 for SSH
#
class base::firewall {
 
  ufw::allow { 'allow-ssh':
    port => '22',
    ip   => 'any'
  }

}
