# repo.pp

class profiles::base::repo {
  include ::profiles::base::repo::config
  include ::profiles::base::repo::centos
  include ::profiles::base::repo::epel
}

