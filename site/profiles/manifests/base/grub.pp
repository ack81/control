class profiles::base::grub {
  file { 'etc_grub.conf':
    ensure => link,
    owner  => 'root',
    group  => 'root',
    mode   => '0777',
    target => '/boot/grub/grub.conf',
    path   => '/etc/grub.conf',
  }

  file { 'grub.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
    path   => '/boot/grub/grub.conf',
  }

  exec { 'grub_selinux':
    path    => '/bin',
    command => 'sed -ie "s/selinux=1/selinux=0/g" /boot/grub/grub.conf',
    onlyif  => 'grep "selinux=1" /boot/grub/grub.conf',
  }

  exec { 'grub_audit_missing':
    path    => '/bin',
    command => 'sed -ie "/kernel /s/$/ audit=1/g" /boot/grub/grub.conf',
    unless  => 'grep "audit=" /boot/grub/grub.conf',
  }

  exec { 'grub_audit':
    path    => '/bin:/usr/bin',
    command => 'sed -ie "/audit=./ s///g" /boot/grub/grub.conf && sed -ie "/kernel /s/$/ audit=1/g" /boot/grub/grub.conf',
    unless  => 'test `grep -v "^#" /boot/grub/grub.conf | grep "audit=1" | wc -l` = `grep -v "^#" /boot/grub/grub.conf | grep "kernel" | wc -l` && grep -v "^#" /boot/grub/grub.conf | grep "audit=1"',
  }

}
