class profiles::accounts::priv {
  case $::osfamily {
    'RedHat': {
      $root_home     = '/root'
      $root_group    = 'root'
      $root_pass     = '$6$5ptW6Yjg$AzstRjRiim9qlTkHHwMlTxGEfj0SjIp.O8GMRgbi2c2ISPJm7.oVjr5QrbMGBH6sgpjrhM2JYJU45WKZ/oogf0'
    }
    default: {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }

  group { $root_group: ensure => present, }

  user { 'root':
    ensure     => present,
    home       => $root_home,
    managehome => true,
    shell      => $default_shell,
    password   => $root_pass,
  }
}
