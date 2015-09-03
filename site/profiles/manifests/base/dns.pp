class profiles::base::dns {
  case $::osfamily {
    'RedHat' : {
      file { '/etc/resolv.conf':
        ensure => present,
        mode   => '0644',
        content => template("profiles/base/dns/resolv.conf.erb"),
      }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
