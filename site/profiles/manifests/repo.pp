# repo.pp

class repo {
  include ::profiles::repo::config
  include ::profiles::repo::centos
  include ::profiles::repo::epel
}

