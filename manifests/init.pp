# @summary Manages a Chronograf
#
# @example
#   include chronograf
class chronograf (
  Boolean $manage_repo = $chronograf::params::manage_repo,
  String $package_name = $chronograf::params::package_name,
  String $ensure_package = $chronograf::params::ensure_package,
  String $repo_location = $chronograf::params::repo_location,
  String $repo_type = $chronograf::params::repo_type,

  String $group = $chronograf::params::group,
  Enum['present', 'absent'] $group_manage = $chronograf::params::group_manage,
  Boolean $group_system = $chronograf::params::group_system,
  String $user = $chronograf::params::user,
  Enum['present', 'absent'] $user_manage = $chronograf::params::user_manage,
  Boolean $user_system = $chronograf::params::user_system,
  Boolean $user_manage_home = $chronograf::params::user_manage_home,
  String $user_home = $chronograf::params::user_home,

  String $service_defaults = $chronograf::params::service_defaults,
  Enum['present', 'absent'] $service_defaults_manage = $chronograf::params::service_defaults_manage,
  String $service_defaults_template = $chronograf::params::service_defaults_template,
  String $service_definition = $chronograf::params::service_definition,
  Enum['present', 'absent'] $service_definition_manage = $chronograf::params::service_definition_manage,
  String $service_definition_template = $chronograf::params::service_definition_template,
  String $service_name = $chronograf::params::service_name,
  String $service_provider = $chronograf::params::service_provider,
  Enum['running', 'stopped'] $service_ensure = $chronograf::params::service_ensure,
  Boolean $service_enable = $chronograf::params::service_enable,
  Boolean $service_has_status = $chronograf::params::service_has_status,
  Boolean $service_has_restart = $chronograf::params::service_has_restart,
  Boolean $manage_service = $chronograf::params::manage_service,
  Boolean $notify_service = $chronograf::params::notify_service,

  String $host = $chronograf::params::host,
  String $port = $chronograf::params::port,
  String $bolt_path = $chronograf::params::bolt_path,
  String $canned_path = $chronograf::params::canned_path,
  String $protoboards_path = $chronograf::params::protoboards_path,
  String $resources_path = $chronograf::params::resources_path,
  Enum['directory', 'absent'] $resources_path_manage = $chronograf::params::resources_path_manage,String $basepath = '',
  String $status_feed_url = $chronograf::params::status_feed_url,

  Hash $connection_influx = $chronograf::params::connection_influx,
  String $influx_connection_template = $chronograf::params::influx_connection_template,
  Hash $connection_kapacitor = $chronograf::params::connection_kapacitor,
  String $kapacitor_connection_template = $chronograf::params::kapacitor_connection_template,

)
  inherits chronograf::params
{

  include ::chronograf::repo
  include ::chronograf::install
  include ::chronograf::config
  contain ::chronograf::service

  Class['chronograf::repo'] ~> Class['chronograf::install']
  Class['chronograf::install'] ~> Class['chronograf::config', 'chronograf::service']

  if $notify_service {
    Class['chronograf::config']
    ~> Class['chronograf::service']
  }


  $connection_influx.each | $connection, $connection_config | {
    chronograf::connection::influx { $connection:
      * => $connection_config,
    }
  }

  $connection_kapacitor.each | $connection, $connection_config | {
    chronograf::connection::kapacitor { $connection:
      * => $connection_config,
    }
  }
}
