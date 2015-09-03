class profiles::base::sysctl {
  case $::osfamily {
    'RedHat' : {
      file { '/etc/sysctl.d/base.conf':
        ensure  => present,
        owner   => '0',
        group   => '0',
        mode    => '0755',
        content => template('profiles/base/sysctl/base.conf.erb'),
        notify  => Kernel::Sysctl['/etc/sysctl.d/base.conf']
      }
      kernel::sysctl { '/etc/sysctl.d/base.conf': }
    }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
