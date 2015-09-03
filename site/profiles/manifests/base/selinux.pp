class profiles::base::selinux (
  $selinux      = 'disabled',
  $selinux_type = 'targeted',) {
  case $::osfamily {
    'RedHat' : {
      file { '/etc/selinux/config':
        mode    => '0644',
        owner   => '0',
        group   => '0',
        content => template('profiles/base/selinux/config.erb'),
      }

      exec { 'setenforce':
        path    => '/bin:/usr/sbin:/usr/bin',
        command => 'setenforce 0',
        onlyif  => 'test "`getenforce`" = "Enforcing"',
      }

      package { 'setroubleshoot': ensure => absent }
    }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
