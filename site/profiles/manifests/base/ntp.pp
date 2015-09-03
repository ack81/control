class profiles::base::ntp {
  $ntp_servers   = [
    'time.apple.com',
  ]
  case $::osfamily {
    'RedHat': {
      $ntp_driftfile  = '/var/lib/ntp/ntp.drift'
    }
    default: {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
  class { '::ntp':
    servers        => $ntp_servers,
    driftfile      => $ntp_driftfile,
    package_manage => $package_manage,
  }
}
