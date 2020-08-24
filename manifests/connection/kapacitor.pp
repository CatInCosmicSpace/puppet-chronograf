# @summary Manages the connections to kapacitor
#
# @example
#   chronograf::connection::kapacitor { 'connection': }
define chronograf::connection::kapacitor (
  String $connection = $title,
  Enum['present', 'absent'] $ensure = 'present',
  String $id = '10000',
  String $src_id = '10000',
  Stdlib::HTTPUrl $url =  'http://localhost:9092',
  Boolean $active = true,
  String $organization = 'example_org',
  String $connection_template = $chronograf::kapacitor_connection_template,
  Stdlib::Absolutepath $resources_path = $chronograf::resources_path,
) {

  file { "${resources_path}/${connection}.kap":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($connection_template),
  }
}
