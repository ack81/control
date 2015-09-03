class profiles::base::grub {

  case $::osfamily {
    'RedHat', 'OLE' : {
      if $::operatingsystemmajrelease == 6 {
        ....
        # - sets the values for the below parameters for each kernel version in /boot/grub/grub.conf
        # - removes the quiet option
        augeas { 'grub.conf':
          context => '/files/boot/grub/grub.conf',
          changes => [
          'setm title[*]/kernel crashkernel 128M',
          'setm title[*]/kernel numa off',
          'setm title[*]/kernel console ttyS1,115200n8',
          'setm title[*]/kernel transparent_hugepage never',
          'setm title[*]/kernel rdloaddriver scsi_dh_rdac',
          'rm title[*]/kernel/quiet',
          ],
        } ->
        ....
        # - replaces multiple rhgb options with a single one before the crashkernel option
        # - add debug option before the newly added rhgb
        # - only do this change if not already done
        augeas { 'grub_debug_option':
          context => '/files/boot/grub/grub.conf',
          changes => [
            'rm title[*]/kernel/rhgb',
            'ins rhgb before title[1]/kernel/crashkernel',
            'ins debug after title[1]/kernel/rhgb',
          ],
          onlyif  => 'match title[1]/kernel/debug size == 0',
        }
      }
    }
    default  : {
      fail("The OS Family ${::osfamily} is not supported by ${title}")
    }
  }
}
