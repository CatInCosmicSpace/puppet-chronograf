# @summary Parameter definiton
#
# @example
#   include chronograf::params
class chronograf::params (
  Boolean $manage_repo = true,
  String $package_name = 'chronograf',
  String $ensure = 'present',
  Stdlib::HTTPSUrl $repo_location = 'https://repos.influxdata.com/',
  String $repo_type = 'stable',

  String $group = 'chronograf',
  String $user = 'chronograf',

  Stdlib::Absolutepath $service_defaults = '/etc/default/chronograf',
  String $service_defaults_template = 'chronograf/service-defaults.erb',
  Stdlib::Absolutepath $service_definition = '/lib/systemd/system/chronograf.service',
  String $service_definition_template = 'chronograf/systemd.service.erb',
  String $service_name = 'chronograf',
  String $service_provider = 'systemd',
  Stdlib::Ensure::Service $service_ensure = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,
  Boolean $manage_service = true,

  Stdlib::Host $host = '0.0.0.0',
  Stdlib::Port::Unprivileged $port = 8888,
  Stdlib::Absolutepath $bolt_path ='/var/lib/chronograf/chronograf-v1.db',
  Stdlib::Absolutepath $canned_path = '/usr/share/chronograf/canned',
  Stdlib::Absolutepath $protoboards_path = '/usr/share/chronograf/protoboards',
  Stdlib::Absolutepath $resources_path = '/usr/share/chronograf/resources',
  Optional[Stdlib::Absolutepath] $basepath = '/usr/share/chronograf/base',
  Stdlib::HTTPSUrl $status_feed_url = 'https://www.influxdata.com/feed/json',

  Hash $connection_influx = {},
  String $influx_connection_template = 'chronograf/influx_connection.erb',
  Hash $connection_kapacitor = {},
  String $kapacitor_connection_template = 'chronograf/kapacitor_connection.erb',

  Variant[Undef, Enum['UNSET'], Stdlib::Host] $default_host = 'UNSET',
  Variant[Undef, Enum['UNSET'], Stdlib::Port::Unprivileged] $default_port = 'UNSET',
  Variant[Undef, Enum['UNSET'], String] $default_tls_certificate = 'UNSET',
  Variant[Undef, Enum['UNSET'], String] $default_token_secret = 'UNSET',
  Variant[Undef, Enum['UNSET'], Enum['error','warn','info','debug']] $default_log_level = 'UNSET',
){

}
