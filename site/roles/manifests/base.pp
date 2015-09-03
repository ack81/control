# base.pp

class roles::base {
  include ::profiles::accounts::config
  include ::profiles::accounts::priv
  include ::profiles::accounts::service
  include ::profiles::files
  include ::profiles::firstrun
  include ::profiles::grub
  include ::profiles::logrotate
  include ::profiles::mta
  include ::profiles::ntp
  include ::profiles::packages
  include ::profiles::repo
  include ::profiles::selinux
  include ::profiles::syslog
}

