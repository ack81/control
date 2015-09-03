define profiles::filesystem::create (
  $target   = '',
  $fstype   = 'ext4',
  $blockdev = '',
  $partnum  = '',
  $start    = '1s',
  $stop     = '-1s',
  $label    = '',
  $owner    = '',
  $group    = '') {
  file { $target:
    ensure => directory,
    mode   => '0755',
    owner  => $owner,
    group  => $group,
  }

  parted { "${blockdev}${partnum}":
    parttype  => 'primary',
    blockdev  => $blockdev,
    partnum   => $partnum,
    partlabel => 'msdos',
    align     => 'minimal',
    start     => $start,
    stop      => $stop,
    require   => File[$target],
  }

  mkfs::ext { "${blockdev}${partnum}":
    fstype  => $fstype,
    label   => $label,
    require => [
      File[$target],
      Parted["${blockdev}${partnum}"],
      ]
  }

  mount { $target:
    ensure  => mounted,
    device  => "LABEL=${label}",
    fstype  => $fstype,
    options => 'defaults',
    atboot  => true,
    require => [
      File[$target],
      Parted["${blockdev}${partnum}"],
      Mkfs::Ext["${blockdev}${partnum}"],
      ],
  }
}
