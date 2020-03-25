# @summary Manages directories and files; service defaults
#
# @example
#   include chronograf::config
class chronograf::config (
  String $service_defaults = $chronograf::service_defaults,
  Enum['present', 'absent'] $service_defaults_manage = $chronograf::service_defaults_manage,
  String $service_default_template = $chronograf::service_default_template,
  String $service_definition = $chronograf::service_definition,
  Enum['present', 'absent'] $service_definition_manage = $chronograf::service_definition_manage,
  String $service_definition_template = $chronograf::service_definition_template,
  String $resources_path = $chronograf::resources_path,
  Enum['directory', 'absent'] $resources_path_manage = $chronograf::resources_path_manage,
){

  file { $service_defaults:
    ensure  => $service_defaults_manage,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_default_template),
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
