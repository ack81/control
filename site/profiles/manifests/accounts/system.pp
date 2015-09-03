class profiles::system::accounts::system {
  include profiles::system::accounts::config
  $default_shell = $profiles::system::accounts::config::default_shell

  # Group resource defaults
  Group {
    ensure     => present,
    forcelocal => true,
  }

  @group { 'apache': gid => '48', }

  # User resource defaults
  User {
    ensure           => present,
    managehome       => true,
    forcelocal       => true,
    password_max_age => '999999',
    shell            => $default_shell,
  }


  @user { 'apache':
    uid   => '48',
    gid   => 'apache',
    home  => '/var/www',
    shell => '/sbin/nologin',
  }

  @user { 'adminuser':
    uid  => '20109',
    gid  => 'webadmin',
    home => '/home/adminuser',
    keys => $adminuser_key,
  }

  $adminuser_key = 'AAAAB3NzaC1yc2EAAAABIwAAAQEAyc+p/tZRvzyc5kDHs6WhQhTZxE54TAq0z75omUbLMsk0AgxdDKtokR01iGKBp0XK2RA6xsqEmajT/jFOP1FNO3lUpQSFkrPwA+CGcg7Uz8t4oVmynsrW50G/AT5WkzgNaGJjus36zfTkz6F4U/x8dvC5om8jxsNCVoU/jsl7w46cXqoY3f3SV0uFGJu4KIy8mk4C0wiNSAzLjsXIgzagn7woq78nif13rR1pY8zHh8sKGZ0l6F//K6wPU4odcA5I5Q4yH+OI+GQulhiyTSdvPUQGrxwuQozjRFp4lYdRHGv4CfzQDQQzhiixNiIy1j+dLMcEnYCOY2xEnAWrY1rSRw=='

  @ssh_authorized_key { 'adminuser':
    ensure => 'present',
    key    => $adminuser_key,
    type   => 'ssh-rsa',
    user   => 'adminuser'
  }

}
