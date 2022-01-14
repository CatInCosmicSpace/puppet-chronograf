# @summary Manages a Chronograf
#
# @example
#   include chronograf
class chronograf (
  Boolean $manage_repo = $chronograf::params::manage_repo,
  String $package_name = $chronograf::params::package_name,
  String $ensure = $chronograf::params::ensure,
  Stdlib::HTTPSUrl $repo_location = $chronograf::params::repo_location,
  String $repo_type = $chronograf::params::repo_type,

  String $group = $chronograf::params::group,
  String $user = $chronograf::params::user,

  String $config_ensure = $chronograf::params::config_ensure,
  Stdlib::Absolutepath $service_defaults = $chronograf::params::service_defaults,
  Stdlib::Absolutepath $service_definition = $chronograf::params::service_definition,
  String $service_definition_template = $chronograf::params::service_definition_template,
  String $service_name = $chronograf::params::service_name,
  String $service_provider = $chronograf::params::service_provider,
  Stdlib::Ensure::Service $service_ensure = $chronograf::params::service_ensure,
  Boolean $service_enable = $chronograf::params::service_enable,
  Boolean $service_has_status = $chronograf::params::service_has_status,
  Boolean $service_has_restart = $chronograf::params::service_has_restart,
  Boolean $manage_service = $chronograf::params::manage_service,

  Stdlib::Absolutepath $bolt_path = $chronograf::params::bolt_path,
  Stdlib::Absolutepath $canned_path = $chronograf::params::canned_path,
  Stdlib::Absolutepath $protoboards_path = $chronograf::params::protoboards_path,
  Stdlib::Absolutepath $resources_path = $chronograf::params::resources_path,
  Optional[Stdlib::Absolutepath] $basepath = $chronograf::params::basepath,
  Optional[Stdlib::HTTPSUrl] $status_feed_url = $chronograf::params::status_feed_url,

  Hash $connection_influx = $chronograf::params::connection_influx,
  String $influx_connection_template = $chronograf::params::influx_connection_template,
  Hash $connection_kapacitor = $chronograf::params::connection_kapacitor,
  String $kapacitor_connection_template = $chronograf::params::kapacitor_connection_template,

  Stdlib::Host $host = $chronograf::params::host,
  Stdlib::Port $port = $chronograf::params::port,
  Variant[Undef, Enum['UNSET'], String] $tls_certificate = $chronograf::params::tls_certificate,
  Variant[Undef, Enum['UNSET'], String] $token_secret = $chronograf::params::token_secret,
  Variant[Undef, Enum['UNSET'], Enum['error','warn','info','debug']] $log_level = $chronograf::params::log_level,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPUrl] $public_url = $chronograf::params::public_url,
  Variant[Undef, Enum['UNSET'], String] $generic_client_id = $chronograf::params::generic_client_id,
  Variant[Undef, Enum['UNSET'], String] $generic_client_secret = $chronograf::params::generic_client_secret,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $generic_auth_url = $chronograf::params::generic_auth_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $generic_token_url = $chronograf::params::generic_token_url,
  Variant[Undef, Enum['UNSET'], Enum['true','false']] $use_id_token = $chronograf::params::use_id_token,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $jwks_url = $chronograf::params::jwks_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $generic_api_url = $chronograf::params::generic_api_url,
  Variant[Undef, Enum['UNSET'], String] $generic_api_key = $chronograf::params::generic_api_key,
  Variant[Undef, Enum['UNSET'], String] $generic_scopes = $chronograf::params::generic_scopes,
  Variant[Undef, Enum['UNSET'], String] $generic_domains = $chronograf::params::generic_domains,
  Variant[Undef, Enum['UNSET'], String] $generic_name = $chronograf::params::generic_name,
  Variant[Undef, Enum['UNSET'], String] $google_client_id = $chronograf::params::google_client_id,
  Variant[Undef, Enum['UNSET'], String] $google_client_secret = $chronograf::params::google_client_secret,
  Variant[Undef, Enum['UNSET'], String] $google_domains = $chronograf::params::google_domains,

)
inherits chronograf::params {
  include chronograf::repo
  include chronograf::install
  include chronograf::config
  contain chronograf::service

  Class['chronograf::repo'] ~> Class['chronograf::install']
  Class['chronograf::install'] ~> Class['chronograf::config', 'chronograf::service']

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
