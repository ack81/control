class profiles::repo::config (
  $reposdir  = '/etc/yum.repos.d',
  $sslverify = '0',
) {
  class { 'yum::config':
    reposdir  => $reposdir,
    sslverify => $sslverify,
  }
}
