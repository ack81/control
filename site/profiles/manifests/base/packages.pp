class profiles::base::packages (
  $packages_install = [
    'parted',
    'net-snmp-utils',
    'nc',
    'bind-utils',
    'man',
    'man-pages',
    'kernel-devel',
    'mailx',
    'lsof',
    'tmpwatch',
    'wget',
    'curl',
    'tree',
    'sysstat',
    ],
  $packages_latest  = [
    'openssl',
    'bash',
    'ksh',
    ],
  $packages_absent  = [
    'mcstrans',
    'bluez',
    'cups',
    'telnet',
    'telnet-server',
    'rsh',
    'rsh-server',
    'ypbind',
    'ypserv',
    'tftp',
    'tftp-server',
    'talk',
    'talk-server',
    'avahi',
    'openldap-servers',
    'bind',
    'bind-chroot',
    'vsftpd',
    'dovecot',
    ]) {
  $pkg_install = $::osfamily ? {
    RedHat  => $packages_install,
    default => '',
  }
  $pkg_latest = $::osfamily ? {
    RedHat  => $packages_latest,
    default => '',
  }
  $pkg_absent = $::osfamily ? {
    RedHat  => $packages_absent,
    default => '',
  }

  if !defined_with_params(Package[$pkg_install], {
    'ensure' => 'present'
  }
  ) {
    package { $pkg_install: ensure => present, }
  }

  if !defined_with_params(Package[$pkg_latest], {
    'ensure' => 'latest'
  }
  ) {
    package { $pkg_latest: ensure => latest, }
  }

  package { $pkg_absent: ensure => 'absent' }
}
