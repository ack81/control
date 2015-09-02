class profiles::redhat (
  $rhn_url  = 'http://rhnsatrk1v.wsgc.com/XMLRPC',
  $rhn_user = 'rhn_puppet',
  $rhn_pass = 'pm@ster5000!',) {
  file { '/etc/yum.repos.d/redhat.repo': ensure => absent }

  file { '/etc/yum.repos.d/rhel-source.repo': ensure => absent }

  class { '::redhat::register':
    rhn_url  => $rhn_url,
    rhn_user => $rhn_user,
    rhn_pass => $rhn_pass,
  }

}
