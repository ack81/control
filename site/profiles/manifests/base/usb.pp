class profiles::base::usb {
  case $::osfamily {
    'RedHat' : {
      exec { '/bin/rm -f /etc/sysconfig/network-scripts/ifcfg-usb*':
        onlyif => '/usr/bin/test -f /etc/sysconfig/network-scripts/ifcfg-usb0',
      }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
