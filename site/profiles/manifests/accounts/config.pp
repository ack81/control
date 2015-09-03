class profiles::system::accounts::config {
  case $::osfamily {
    'RedHat': {

      $default_shell = '/bin/bash'

      file { '/etc/login.defs':
        mode    => '0644',
        owner   => '0',
        group   => '0',
        content => template('profiles/accounts/login.defs.erb'),
      }

    }

    default: {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }

  }

}
