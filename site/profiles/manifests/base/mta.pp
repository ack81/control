class profiles::base::mta (
  $mta_relayhost = 'mailhost.wsgc.com',) {
  case $::osfamily {
    'RedHat' : {
      class { '::postfix':
        relayhost => $mta_relayhost,
        myorigin  => $::fqdn,
        options   => {
          inet_protocols => 'ipv4'
        }
      }
    }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
