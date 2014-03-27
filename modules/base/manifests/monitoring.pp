# Class = base::monitoring
#
# Create Icinga/Nagios alerts for:
#   - lack of disk space on the back-up drive
#   - lack of replies to ICMP requests

class base::monitoring (
  [
    $fqdn,
    $hostname,
  ]
){

  icinga::host { $fqdn:
    hostalias => $fqdn,
    address   => $fqdn,
  }

  icinga::check { "check_disk_${fqdn}":
    check_command       => 'check_nrpe_1arg!check_xvda1',
    use                 => 'govuk_high_priority',
    service_description => 'high disk usage'
    use                 => 'govuk_high_priority',
    host_name           => $fqdn,
  }

  icinga::check { "check_ping_${fqdn}":
    check_command       => 'check_ping!100.0,20%!500.0,60%',
    notification_period => '24x7',
    use                 => 'govuk_high_priority',
    service_description => 'unable to ping',
    host_name           => $fqdn
  }
}
