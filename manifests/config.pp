# @summary Manages directories and files; service defaults
#
# @example
#   include chronograf::config
class chronograf::config (
  Stdlib::Absolutepath $service_defaults = $chronograf::service_defaults,
  Stdlib::Absolutepath $service_definition = $chronograf::service_definition,
  String $service_definition_template = $chronograf::service_definition_template,
  String $resources_path = $chronograf::resources_path,
  String $user = $chronograf::user,
  String $group = $chronograf::group,
  Stdlib::Absolutepath $bolt_path = $chronograf::bolt_path,
  Stdlib::Absolutepath $canned_path = $chronograf::canned_path,
  Stdlib::Absolutepath $protoboards_path = $chronograf::protoboards_path,
  Optional[Stdlib::Absolutepath] $basepath = $chronograf::basepath,
  Optional[Stdlib::HTTPSUrl] $status_feed_url = $chronograf::status_feed_url,
  Stdlib::Host $host = $chronograf::host,
  Stdlib::Port $port = $chronograf::port,
  Variant[Undef, Enum['UNSET'], String] $tls_certificate = $chronograf::tls_certificate,
  Variant[Undef, Enum['UNSET'], String] $token_secret = $chronograf::token_secret,
  Variant[Undef, Enum['UNSET'], Enum['error','warn','info','debug']] $log_level = $chronograf::log_level,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPUrl] $public_url = $chronograf::public_url,
  Variant[Undef, Enum['UNSET'], String] $generic_client_id = $chronograf::generic_client_id,
  Variant[Undef, Enum['UNSET'], String] $generic_client_secret = $chronograf::generic_client_secret,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $generic_auth_url = $chronograf::generic_auth_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $generic_token_url = $chronograf::generic_token_url,
  Variant[Undef, Enum['UNSET'], Enum['true','false']] $use_id_token = $chronograf::use_id_token,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $jwks_url = $chronograf::jwks_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $generic_api_url = $chronograf::generic_api_url,
  Variant[Undef, Enum['UNSET'], String] $generic_api_key = $chronograf::generic_api_key,
  Variant[Undef, Enum['UNSET'], String] $generic_scopes = $chronograf::generic_scopes,
  Variant[Undef, Enum['UNSET'], String] $generic_domains = $chronograf::generic_domains,
  Variant[Undef, Enum['UNSET'], String] $generic_name = $chronograf::generic_name,
  Variant[Undef, Enum['UNSET'], String] $google_client_id = $chronograf::google_client_id,
  Variant[Undef, Enum['UNSET'], String] $google_client_secret = $chronograf::google_client_secret,
  Variant[Undef, Enum['UNSET'], String] $google_domains = $chronograf::google_domains,
){

  include systemd::systemctl::daemon_reload

  $keys = [
    'HOST',
    'PORT',
    'TLS_CERTIFICATE',
    'TOKEN_SECRET',
    'LOG_LEVEL',
    'PUBLIC_URL',
    'GENERIC_CLIENT_ID',
    'GENERIC_CLIENT_SECRET',
    'GENERIC_AUTH_URL',
    'GENERIC_TOKEN_URL',
    'USE_ID_TOKEN',
    'JWKS_URL',
    'GENERIC_API_URL',
    'GENERIC_API_KEY',
    'GENERIC_SCOPES',
    'GENERIC_DOMAINS',
    'GENERIC_NAME',
    'GOOGLE_CLIENT_ID',
    'GOOGLE_CLIENT_SECRET',
    'GOOGLE_DOMAINS',
  ]

  $keys.each | $key| {
    $value = getvar("${key.downcase}")

    if  $value != 'UNSET' {
      augeas { "set_${key.downcase}":
        context => "/files${service_defaults}",
        incl    => $service_defaults,
        lens    => 'Shellvars.lns',
        changes => [
          "set ${key} ${value}",
        ]
      }
    }
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
