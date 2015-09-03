class profiles::base::ntp {
  $ntp_servers   = [
    '192.168.41.123',
    '192.168.152.123',
  ]
  case $::osfamily {
    'RedHat': {
      $ntp_driftfile  = '/var/lib/ntp/ntp.drift'
    }
    'AIX': {
      $package_manage = false
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
