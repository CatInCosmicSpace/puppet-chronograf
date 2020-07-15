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
  Variant[Undef, Enum['UNSET'], Stdlib::Host] $default_host = $chronograf::default_host,
  Variant[Undef, Enum['UNSET'], Stdlib::Port::Unprivileged] $default_port = $chronograf::default_port,
  Variant[Undef, Enum['UNSET'], String] $default_tls_certificate = $chronograf::default_tls_certificate,
  Variant[Undef, Enum['UNSET'], String] $default_token_secret = $chronograf::default_token_secret,
  Variant[Undef, Enum['UNSET'], Enum['error','warn','info','debug']] $default_log_level = $chronograf::default_log_level,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPUrl] $default_public_url = $chronograf::default_public_url,
  Variant[Undef, Enum['UNSET'], String] $default_generic_client_id = $chronograf::default_generic_client_id,
  Variant[Undef, Enum['UNSET'], String] $default_generic_client_secret = $chronograf::default_generic_client_secret,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_generic_auth_url = $chronograf::default_generic_auth_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_generic_token_url = $chronograf::default_generic_token_url,
  Variant[Undef, Enum['UNSET'], Enum['true','false']] $default_use_id_token = $chronograf::default_use_id_token,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_jwks_url = $chronograf::default_jwks_url,
  Variant[Undef, Enum['UNSET'], Stdlib::HTTPSUrl] $default_generic_api_url = $chronograf::default_generic_api_url,
  Variant[Undef, Enum['UNSET'], String] $default_generic_api_key = $chronograf::default_generic_api_key,
  Variant[Undef, Enum['UNSET'], String] $default_generic_scopes = $chronograf::default_generic_scopes,
  Variant[Undef, Enum['UNSET'], String] $default_generic_domains = $chronograf::default_generic_domains,
  Variant[Undef, Enum['UNSET'], String] $default_generic_name = $chronograf::default_generic_name,
  Variant[Undef, Enum['UNSET'], String] $default_google_client_id = $chronograf::default_google_client_id,
  Variant[Undef, Enum['UNSET'], String] $default_google_client_secret = $chronograf::default_google_client_secret,
  Variant[Undef, Enum['UNSET'], String] $default_google_domains = $chronograf::default_google_domains,
){

  include systemd::systemctl::daemon_reload

#  file { $service_defaults:
#    ensure  =>  present,
#    owner   => 'root',
#    group   => 'root',
#    mode    => '0644',
#    content => template($service_defaults_template),
#  }

  $keys = [
    'HOST',
    'PORT',
    'TLS_CERTIFICATE',
    'TOKEN_SECRET',
    'LOG_LEVEL',
    'PUBLIC_URL',
    'ENERIC_CLIENT_ID',
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
    $value = getvar("default_${key.downcase}")

    if  $value != 'UNSET' {
      augeas { "set_default_${key.downcase}":
        context => '/files/etc/default/chronograf',
        incl    => '/etc/default/chronograf',
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
