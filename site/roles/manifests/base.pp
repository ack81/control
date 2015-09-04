# base.pp

class roles::base {
  include ::profiles::base::accounts::config
  include ::profiles::base::accounts::priv
  include ::profiles::base::accounts::service
  include ::profiles::base::files
  include ::profiles::base::firstrun
  include ::profiles::base::grub
  include ::profiles::base::logrotate
  include ::profiles::base::mta
  include ::profiles::base::ntp
  include ::profiles::base::packages
  include ::profiles::base::repo
  include ::profiles::base::selinux
  include ::profiles::base::syslog
}

