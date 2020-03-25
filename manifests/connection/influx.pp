# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   chronograf::influx { 'connection': }
define chronograf::influx (
  String $connection = $title,
  Enum['present', 'absent'] $ensure = 'present',
  String $id = '10000',
  String $username = 'test',
  String $password = 'test',
  String $url = 'http://localhost:8086',
  String $type = 'influx',
  Boolean $insecure_skip_verify = false,
  Boolean $default = true,
  String $telegraf = 'telegraf',
  String $organization = 'example_org',
  String $connection_template = $chronograf::influx_connection_template,
  String $resources_path = '/usr/share/chronograf/resources',
) {

  file { "${resources_path}/${connection}.src":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template($connection_template),





}
