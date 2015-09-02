class profiles::syslog {

  case $::osfamily {
    'RedHat': {
      $pkg_name      = 'rsyslog'
      $conf_file     = '/etc/rsyslog.conf'
      $conf_template = 'rsyslog.conf.erb'
      $svc_name      = 'rsyslog'
    }
    'AIX': {
      $conf_file     = '/etc/syslog.conf'
      $conf_template = 'syslog.conf.erb'
      $svc_name      = 'syslogd'
    }
    default: {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }

  if $pkg_name {
    package { $pkg_name: ensure => installed }
  }

  file { $conf_file:
    ensure  => file,
    mode    => '0644',
    group   => '0',
    owner   => '0',
    content => template("profiles/base/syslog/${conf_template}"),
    require => Package[$pkg_name],
  }

  service { $svc_name:
    ensure    => running,
    enable    => true,
    subscribe => File[$conf_file],
  }

}
