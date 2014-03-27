# Class = base::monitoring
#
# Create Icinga/Nagios alerts for:
#   - lack of disk space on the back-up drive
#   - lack of replies to ICMP requests

class base::monitoring {

  @@icinga::check { "check_disk_${::hostname})":
    check_command       => 'check_nrpe_1arg!check_xvda1',
    use                 => 'govuk_high_priority',
    service_description => 'high disk usage'
  }

  @@icinga::check { "check_ping_${::hostname})":
    check_command       => 'check_ping!100.0,20%!500.0,60%',
    notification_period => '24x7',
    use                 => 'govuk_high_priority',
    service_description => 'unable to ping',
    host_name           => $::fqdn,
  }
}
