class ssh::service(
  String $service_name = $::ssh::service_name
) {
  service { 'ssh':
    ensure     => running,
    name       => $service_name,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}
