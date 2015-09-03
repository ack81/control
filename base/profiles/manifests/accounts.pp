# accounts.pp

class accounts {
  include ::profiles::accounts::config
  include ::profiles::accounts::priv
  include ::profiles::accounts::service
}

