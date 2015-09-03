class profiles::puppet::pe_activemq::config {
  file { '/etc/security/limits.d/99-pe-activemq.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('profiles/puppet/pe_activemq/pe_activemq_limits.conf.erb'),
    notify  => Service['pe-activemq'],
  }
}
