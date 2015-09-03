class profiles::repo::epel {
  require ::profiles::repo::config

  class { '::epel':
    epel_mirrorlist                => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.epel',
    epel_baseurl                   => 'absent',
    epel_failovermethod            => 'priority',
    epel_enabled                   => '1',
    epel_gpgcheck                  => '1',
    epel_testing_enabled           => '0',
    epel_testing_source_enabled    => '0',
    epel_testing_debuginfo_enabled => '0',
    epel_source_enabled            => '0',
    epel_debuginfo_enabled         => '0',
  }
}
