class ssh::params {
  $permit_root_login = false

  case $facts['os']['family'] {
    'Debian': {
      $package_name = 'openssh-server'
      $service_name = 'ssh'
      #$config_source = 'puppet:///modules/ssh/sshd_config_debian'
      $config_source = 'ssh/sshd_config_debian.erb'
    } 
    'RedHat': {
      $package_name = 'openssh-server'
      $service_name = 'sshd'
      case $facts['os']['name'] {
        'CentOS': {
          case $facts['os']['release']['major'] {
            '6': {
              #$config_source = 'puppet:///modules/ssh/sshd_config_centos6'
              $config_source = 'ssh/sshd_config_centos6.erb'
            }
            '7': {
              #$config_source = 'puppet:///modules/ssh/sshd_config_centos7'
              $config_source = 'ssh/sshd_config_centos7.erb'
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
}
