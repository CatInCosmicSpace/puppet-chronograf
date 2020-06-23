# @summary Manages directories and files; service defaults
#
# @example
#   include chronograf::config
class chronograf::config (
  String $service_defaults = $chronograf::service_defaults,
  Enum['present', 'absent'] $service_defaults_manage = $chronograf::service_defaults_manage,
  String $service_defaults_template = $chronograf::service_defaults_template,
  String $service_definition = $chronograf::service_definition,
  Enum['present', 'absent'] $service_definition_manage = $chronograf::service_definition_manage,
  String $service_definition_template = $chronograf::service_definition_template,
  String $resources_path = $chronograf::resources_path,
  Enum['directory', 'absent'] $resources_path_manage = $chronograf::resources_path_manage,
  String $user = $chronograf::user,
  String $group = $chronograf::group,
  String $host = $chronograf::host,
  String $port = $chronograf::port,
  String $bolt_path = $chronograf::bolt_path,
  String $canned_path = $chronograf::canned_path,
  String $protoboards_path = $chronograf::protoboards_path,
  String $basepath = $chronograf::basepath,
  String $status_feed_url = $chronograf::status_feed_url,
){

  file { $service_defaults:
    ensure  => $service_defaults_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_defaults_template),
  }

  -> file { $service_definition:
      ensure  => $service_definition_manage,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template($service_definition_template),
  }

  file { $resources_path:
    ensure => $resources_path_manage,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

}
