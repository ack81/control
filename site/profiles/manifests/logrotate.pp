class profiles::logrotate {
  case $::osfamily {
    'RedHat' : {
      file { '/etc/logrotate.d/syslog':
        mode    => '0644',
        owner   => '0',
        group   => '0',
        content => template('profiles/logrotate/syslog.erb'),
      }
    }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
