function ssh::data() {
  $base_params = {
    'ssh::permit_root_login' => false,
  }

  case $facts['os']['family'] {
    'Debian': {
      $os_params = {
        'ssh::package_name' => 'openssh-server',
        'ssh::service_name' => 'ssh',
      }
      $extra_os_params = {
        #'ssh::config_source' => 'puppet:///modules/ssh/sshd_config_debian',
        'ssh::config_source' => 'ssh/sshd_config_debian.erb',
      }
    }
    'RedHat': {
      $os_params = {
        'ssh::package_name' => 'openssh-server',
        'ssh::service_name' => 'sshd',
      }
      case $facts['os']['name'] {
        'CentOS': {
          case $facts['os']['release']['major'] {
            '6': {
              $extra_os_params = {
                #'ssh::config_source' => 'puppet:///modules/ssh/sshd_config_centos6',
                'ssh::config_source' => 'ssh/sshd_config_centos6.erb',
              }
            }
            '7': {
              $extra_os_params = {
                #'ssh::config_source' => 'puppet:///modules/ssh/sshd_config_centos7',
                'ssh::config_source' => 'ssh/sshd_config_centos7.erb',
              }
            }
            default: {
              fail("${facts['os']['release']['major']} for CentOS is not suppported")
            }
          }
        }
        default: {
          fail("${facts['os']['name']} is not suppported")
        }
      }

    }
    default: {
      fail("${facts['operatingsystem']} is not suppported")
    }

  }
  $base_params + $os_params + $extra_os_params
}
