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

  Stdlib::Absolutepath $service_defaults = $chronograf::params::service_defaults,
  String $service_defaults_template = $chronograf::params::service_defaults_template,
  Stdlib::Absolutepath $service_definition = $chronograf::params::service_definition,
  String $service_definition_template = $chronograf::params::service_definition_template,
  String $service_name = $chronograf::params::service_name,
  String $service_provider = $chronograf::params::service_provider,
  Stdlib::Ensure::Service $service_ensure = $chronograf::params::service_ensure,
  Boolean $service_enable = $chronograf::params::service_enable,
  Boolean $service_has_status = $chronograf::params::service_has_status,
  Boolean $service_has_restart = $chronograf::params::service_has_restart,
  Boolean $manage_service = $chronograf::params::manage_service,

  Stdlib::Host $host = $chronograf::params::host,
  Stdlib::Port::Unprivileged $port = $chronograf::params::port,
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

  Variant[Undef, Enum['UNSET'], Stdlib::Host] $default_host = $chronograf::params::default_host,
  Variant[Undef, Enum['UNSET'], Stdlib::Port::Unprivileged] $default_port = $chronograf::params::default_port,
  Variant[Undef, Enum['UNSET'], String] $default_tls_certificate = $chronograf::params::default_tls_certificate,
  Variant[Undef, Enum['UNSET'], String] $default_token_secret = $chronograf::params::default_token_secret,
  Variant[Undef, Enum['UNSET'], Enum['error','warn','info','debug']] $default_log_level = $chronograf::params::default_log_level,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPUrl] $default_public_url = $chronograf::params::default_public_url,
  Variant[Undef, Enum['UNSET'], String] $default_generic_client_id = $chronograf::params::default_generic_client_id,
  Variant[Undef, Enum['UNSET'], String] $default_generic_client_secret = $chronograf::params::default_generic_client_secret,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_generic_auth_url = $chronograf::params::default_generic_auth_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_generic_token_url = $chronograf::params::default_generic_token_url,
  Variant[Undef, Enum['UNSET'], Enum['true','false']] $default_use_id_token = $chronograf::params::default_use_id_token,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_jwks_url = $chronograf::params::default_jwks_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_generic_api_url = $chronograf::params::default_generic_api_url,
  Variant[Undef, Enum['UNSET'], String] $default_generic_api_key = $chronograf::params::default_generic_api_key,
  Variant[Undef, Enum['UNSET'], String] $default_generic_scopes = $chronograf::params::default_generic_scopes,
  Variant[Undef, Enum['UNSET'], String] $default_generic_domains = $chronograf::params::default_generic_domains,
  Variant[Undef, Enum['UNSET'], String] $default_generic_name = $chronograf::params::default_generic_name,
  Variant[Undef, Enum['UNSET'], String] $default_google_client_id = $chronograf::params::default_google_client_id,
  Variant[Undef, Enum['UNSET'], String] $default_google_client_secret = $chronograf::params::default_google_client_secret,
  Variant[Undef, Enum['UNSET'], String] $default_google_domains = $chronograf::params::default_google_domains,

)
  inherits chronograf::params
{

  include ::chronograf::repo
  include ::chronograf::install
  include ::chronograf::config
  contain ::chronograf::service

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
