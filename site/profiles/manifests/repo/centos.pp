class profiles::repo::centos {
  if $::operatingsystem == 'CentOS' {
    require ::profiles::repo::config

    file { '/etc/yum.repos.d/CentOS-Debuginfo.repo': ensure => 'absent', }

    file { '/etc/yum.repos.d/CentOS-fasttrack.repo': ensure => 'absent', }

    file { '/etc/yum.repos.d/CentOS-Media.repo': ensure => 'absent', }

    file { '/etc/yum.repos.d/CentOS-Vault.repo': ensure => 'absent', }

    yumrepo { 'base':
      ensure     => present,
      descr      => 'CentOS-$releasever - Base',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever",
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.base',
      sslverify  => '0',
    }

    yumrepo { 'base-debuginfo':
      ensure     => present,
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.base-debuginfo',
      descr      => 'CentOS-6 - Debuginfo',
      enabled    => '0',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-\$releasever",
      sslverify  => '0',
    }

    yumrepo { 'centosplus':
      ensure     => present,
      descr      => 'CentOS-$releasever - Plus',
      enabled    => '0',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever",
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.plus',
      sslverify  => '0',
    }

    yumrepo { 'contrib':
      ensure     => present,
      descr      => 'CentOS-$releasever - Contrib',
      enabled    => '0',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever",
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.contrib',
      sslverify  => '0',
    }

    yumrepo { 'extras':
      ensure     => present,
      descr      => 'CentOS-$releasever - Extras',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever",
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.extras',
      sslverify  => '0',
    }

    yumrepo { 'fasttrack':
      ensure     => present,
      descr      => 'CentOS-6 - fasttrack',
      enabled    => '0',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever",
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.fasttrack',
      sslverify  => '0',
    }

    yumrepo { 'updates':
      ensure     => present,
      descr      => 'CentOS-$releasever - Updates',
      gpgcheck   => '1',
      gpgkey     => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-\$releasever",
      mirrorlist => 'https://pkgs.wsgc.com/linux/mirrors/mirrors.centos.updates',
      sslverify  => '0',
    }
  }
}
