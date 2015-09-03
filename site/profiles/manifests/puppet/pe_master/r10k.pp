class profiles::puppet::pe_master::r10k (
  $pe_control_repo   = 'ssh://git@gitprdrk01v.wsgc.com/puppet/control.git',
  $pe_deploy_ssh_key = template('profiles/puppet/pe_master/puppetmaster.rsa'),
) {
  include r10k::mcollective

  class { '::r10k': remote => $pe_control_repo }

  class { 'r10k::webhook::config':
    enable_ssl => false,
    protected  => false,
  }

  class { 'r10k::webhook':
    require => Class['r10k::webhook::config'],
  }

  file { '/root/.ssh':
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0700',
  }

  file { '/root/.ssh/config':
    ensure  => 'file',
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template('profiles/puppet/pe_master/config.erb'),
    require => File['/root/.ssh'],
  }

  file { '/root/.ssh/puppetmaster_rsa':
    ensure  => 'file',
    owner   => '0',
    group   => '0',
    mode    => '0600',
    content => $pe_deploy_ssh_key,
    require => File['/root/.ssh'],
  }

  sshkey { [
    'gitprdrk01v',
    'gitprdrk01v.wsgc.com',
    ]:
    ensure  => 'present',
    type    => 'ssh-rsa',
    target  => '/root/.ssh/known_hosts',
    key     => 'AAAAB3NzaC1yc2EAAAABIwAAAQEAvhhrFEQbw9yB7YWBjiyYY2N3nAn91JpIoqtsI/C9vUtnuZiXSj+PpjdOUDqA9uUbDI1B1/kIXKi8Q1TGxIziL7JglDTsCYsHibtfvj9RFRSuT5QOWZnH5x1V6uFEuoKICrYQQmaeTPduJQe9+X5ZqZuKVYYfreGqzTbALtvC4YuUuE1QZUZ4StDt5SWKNDG72v2RyITgalve20h0RxPu38xKq/n0k3oopX3ntWpTq4TeSDWi8qCZ7NupaW8Kj1TX9UctF8u880cymMH8Eg/CvX+/39Weu4jyrLLU79o7SvUnv9OcGwKChByHag6r2Eh4elbmT5JplL1Cr7SzLQ7GKw==',
    require => File['/root/.ssh'],
  }

}
