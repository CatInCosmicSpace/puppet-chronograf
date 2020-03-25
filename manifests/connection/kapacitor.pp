# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   chronograf::connection::kapacitor { 'connection': }
define chronograf::connection::kapacitor (
  String $connection = $title,
  Enum['present', 'absent'] $ensure = 'present',
  String $id = '10000',
  String $src_id = '10000',
  String $url =  'http://localhost:9092',
  Boolean $active = true,
  String $organization = 'example_org',
  String $connection_template = $chronograf::kapacitor_connection_template,
  String $resources_path = '/usr/share/chronograf/resources',
) {

  file { "${resources_path}/${connection}.kap":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($connection_template),

}
