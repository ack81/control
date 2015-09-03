class profiles::base {
  if $::kernel in [ 'Linux', 'AIX' ] {
    file { '/etc/issue.net':
      ensure => link,
      target => '/etc/motd',
    }
  }

  case $::osfamily {
    'RedHat' : {
      exec { 'stickybit_world_write_dirs':
        command => "df --local -P | awk {'if (NR!=1) print \\\$6'} | xargs -I '{}' find '{}' -xdev -type d \\( -perm -0002 -a ! -perm -1000 \\) 2>/dev/null | xargs chmod a+t",
        unless  => "df --local -P | awk {'if (NR!=1) print \\\$6'} | xargs -I '{}' find '{}' -xdev -type d \\( -perm -0002 -a ! -perm -1000 \\) 2>/dev/null",
        path    => '/bin:/usr/bin',
      }

      File {
        group => '0',
        owner => '0',
      }

      file { '/var/log/boot.log':
        mode => '0600',
      }

      file { [
        '/etc/passwd',
        '/etc/group',
      ]:
        mode => '0644',
      }
      file { [
        '/etc/shadow',
        '/etc/gshadow',
      ]:
        mode => '0000', # TODO: verify this
      }

      file { '/etc/crontab':
        mode => '0400',
      }
      file { [
        '/var/spool/cron/deny',
        '/var/spool/cron/allow',
      ]:
        mode => '0644',
      }
      file { [
        '/etc/cron.hourly',
        '/etc/cron.daily',
        '/etc/cron.weekly',
        '/etc/cron.monthly',
        '/etc/cron.d',
      ]:
        mode => '0700',
      }
      file { [
        '/etc/at.allow',
        '/etc/cron.allow',
      ]:
        ensure => file,
        mode   => '0700',
      }
      file { [
        '/etc/cron.deny',
        '/etc/at.deny',
      ]:
        ensure => absent,
      }

    }
    'AIX'    : {

      file_line { 'security_profile_tmout':
        path  => '/etc/security/.profile',
        line  => 'TMOUT=900 ; TIMEOUT=900 ; export readonly TMOUT TIMEOUT',
        match => '^TMOUT=',
      }

      user { 'guest':
        ensure => absent,
      }
      file { '/home/guest':
        ensure => absent,
        force  => true,
      }

      file { '/etc/inetd.conf':
        ensure => file,
        owner  => 'root',
        group  => 'system',
        mode   => '0644',
      }

      file { '/etc/sendmail.cf':
        ensure => file,
        owner  => 'root',
        mode   => '0640',
      }

      file { '/var/spool/mqueue':
        ensure => directory,
        owner  => 'root',
        mode   => '0700',
      }

      file { '/etc/group':
        ensure => file,
        owner  => 'root',
        group  => 'security',
        mode   => '0644',
      }

      file { '/etc/passwd':
        ensure => file,
        owner  => 'root',
        group  => 'security',
        mode   => '0644',
      }

      file { '/etc/security':
        ensure => directory,
        owner  => 'root',
        group  => 'audit',
        mode   => '0755',
      }

      # to do : recursively manage permissions in dir
      file { '/etc/security/audit':
        ensure => directory,
        owner  => 'root',
        group  => 'audit',
        mode   => '0750',
      }

      # to do : recursively manage permissions in dir
      file { '/audit':
        ensure => directory,
        owner  => 'root',
        group  => 'audit',
        mode   => '0750',
      }

      file { '/smit.log':
        ensure => file,
        mode   => '0640',
      }

      file { '/var/adm/cron/log':
        ensure => file,
        mode   => '0660',
      }

      # to do : recursively manage permissions in dir
      file { '/var/spool/cron/crontabs':
        ensure => directory,
        group  => 'cron',
        mode   => '0770',
      }

      file { '/var/adm/cron/at.allow':
        ensure => file,
        owner  => 'root',
        group  => 'sys',
        mode   => '0400',
      }

      file { '/var/adm/cron/cron.allow':
        ensure => file,
        owner  => 'root',
        group  => 'sys',
        mode   => '0400',
      }

      file { '/etc/motd':
        ensure => file,
        owner  => 'bin',
        group  => 'bin',
        mode   => '0644',
      }

      # to do : recursively manage permissions in dir
      #  file { '/var/adm/ras':
      #    ensure => directory,
      #  }

      file { '/var/ct/RMstart.log':
        ensure => file,
        mode   => '0640',
      }

      file { '/var/adm/sa':
        ensure => directory,
        owner  => 'adm',
        group  => 'adm',
        mode   => '0755',
      }

      file { '/etc/hosts.equiv':
        ensure => absent,
      }

    }

    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }

  }

}
