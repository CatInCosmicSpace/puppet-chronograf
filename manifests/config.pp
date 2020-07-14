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
  Optional[String] $default_host = $chronograf::default_host,
  Optional[String] $default_port = $chronograf::default_port,
  Optional[String] $default_tls_certificate = $chronograf::default_tls_certificate,
  Optional[String] $default_token_secret = $chronograf::default_token_secret,
  Optional[String] $default_log_level = $chronograf::default_log_level,
){

  include systemd::systemctl::daemon_reload

  file { $service_defaults:
    ensure  =>  present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($service_defaults_template),
  }

  if  $default_host != '' {
    augeas { 'set_default_host':
      context => '/files/etc/default/chronograf',
      incl    => '/etc/default/chronograf',
      lens    => 'Shellvars.lns',
      changes => [
        "set HOST ${default_host}",
      ]
    }
  }
  if $default_port != '' {
    augeas { 'set_default_port':
      context => '/files/etc/default/chronograf',
      incl    => '/etc/default/chronograf',
      lens    => 'Shellvars.lns',
      changes => [
        "set PORT ${default_port}",
      ]
    }
  }

  if $default_tls_certificate != '' {
    augeas { 'set_default_tls_certificate':
      context => '/files/etc/default/chronograf',
      incl    => '/etc/default/chronograf',
      lens    => 'Shellvars.lns',
      changes => [
        "set TLS_CERTIFICATE ${default_tls_certificate}",
      ]
    }
  }

  if $default_token_secret != '' {
    augeas { 'set_default_token_secret':
      context => '/files/etc/default/chronograf',
      incl    => '/etc/default/chronograf',
      lens    => 'Shellvars.lns',
      changes => [
        "set TOKEN_SECRET ${default_token_secret}",
      ]
    }
  }

  if $default_log_level != '' {
    augeas { 'set_default_log_level':
      context => '/files/etc/default/chronograf',
      incl    => '/etc/default/chronograf',
      lens    => 'Shellvars.lns',
      changes => [
        "set LOG_LEVEL ${default_log_level}",
      ]
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
