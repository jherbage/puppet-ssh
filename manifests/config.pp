class ssh::config(
  Boolean $permit_root_login = $::ssh::permit_root_login,
  String $config_source = $::ssh::config_source,
  Integer $port = $::ssh::port,
) {
  file { '/etc/ssh/sshd_config':
    ensure     => file,
    owner      => 'root',
    group      => 'root', 
    mode       => '0600',
    content     => template($config_source),
  }
}

