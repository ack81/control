class profiles::puppet::pe_agent::package (
  $pe_master = 'cfgprdsac01v.wsgc.com',
  $version   = 'current',
) {
  case $::osfamily {
    'RedHat' : {
      yumrepo { 'puppetlabs-pepackages':
        ensure    => present,
        baseurl   => "https://${pe_master}:8140/packages/${version}/el-6-x86_64",
        descr     => 'Puppet Labs PE Packages $releasever - $basearch',
        enabled   => '1',
        gpgcheck  => '1',
        gpgkey    => "https://${pe_master}:8140/packages/GPG-KEY-puppetlabs",
        proxy     => '_none_',
        sslverify => 'False',
        before    => Package['pe-puppet-enterprise-release'],
      }

      package { 'pe-puppet-enterprise-release': ensure => latest }
    }
    default  : {
      notice("The OS Family '${::osfamily}' is not supported by module '::profiles::pe_agent::package' ${title}")
    }
  }
}
