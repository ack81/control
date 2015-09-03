class profiles::puppet::pe_master::hiera {
  file { '/etc/puppetlabs/puppet/hiera.yaml':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    content => template('profiles/puppet/pe_master/hiera.yaml.erb'),
    notify  => Service['pe-puppetserver'],
  }
  include r10k::install::pe_gem

  package { 'hiera-http':
    ensure   => '1.3.1',
    provider => 'pe_gem'
  }
}
