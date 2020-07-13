# @summary Manages directories and files; service defaults
#
# @example
#   include chronograf::config
class chronograf::config (
  Stdlib::Absolutepath $service_defaults = $chronograf::service_defaults,
  String $service_defaults_template = $chronograf::service_defaults_template,
  Stdlib::Absolutepath $service_definition = $chronograf::service_definition,
  String $service_definition_template = $chronograf::service_definition_template,
  String $resources_path = $chronograf::resources_path,
  String $user = $chronograf::user,
  String $group = $chronograf::group,
  Stdlib::Host $host = $chronograf::host,
  Stdlib::Port::Unprivileged $port = $chronograf::port,
  Stdlib::Absolutepath $bolt_path = $chronograf::bolt_path,
  Stdlib::Absolutepath $canned_path = $chronograf::canned_path,
  Stdlib::Absolutepath $protoboards_path = $chronograf::protoboards_path,
  Optional[Stdlib::Absolutepath] $basepath = $chronograf::basepath,
  Optional[Stdlib::HTTPSUrl] $status_feed_url = $chronograf::status_feed_url,
  Hash $defaults_service = $chronograf::defaults_service,
){

  include systemd::systemctl::daemon_reload

  file { $service_defaults:
    ensure  =>  present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_defaults_template),
  }

  file { $service_definition:
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($service_definition_template),
  }
  ~> Class['systemd::systemctl::daemon_reload']

  file { $resources_path:
    ensure =>  directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
