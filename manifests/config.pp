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
){

  include systemd::systemctl::daemon_reload

  file { $service_defaults:
    ensure  =>  present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_defaults_template),
  }

  $keys = [
    'HOST',
    'PORT',
    'TLS_CERTIFICATE',
    'TOKEN_SECRET',
    'LOG_LEVEL',
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
