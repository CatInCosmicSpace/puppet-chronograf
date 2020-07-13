# @summary Manages directories and files; service defaults
#
# @example
#   include chronograf::config
class chronograf::config (
  String $service_defaults = $chronograf::service_defaults,
  String $service_defaults_template = $chronograf::service_defaults_template,
  String $service_definition = $chronograf::service_definition,
  String $service_definition_template = $chronograf::service_definition_template,
  String $resources_path = $chronograf::resources_path,
  String $user = $chronograf::user,
  String $group = $chronograf::group,
  String $host = $chronograf::host,
  String $port = $chronograf::port,
  String $bolt_path = $chronograf::bolt_path,
  String $canned_path = $chronograf::canned_path,
  String $protoboards_path = $chronograf::protoboards_path,
  String $basepath = $chronograf::basepath,
  String $status_feed_url = $chronograf::status_feed_url,
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

  -> file { $service_definition:
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
