class profiles::base::firstrun {
  include ::firstrun

  $mail_akinney   = 'akinney@apple.com',

  firstrun_mail('Continuous Delivery<peadmin>', $mail_akinney, "New ${::operatingsystem} platform deployed", template('profiles/base/firstrun/deploy_mail.erb'
  ),)

  if $::firstrun == 'true' {
    include yum::update
  }
}
