# @summary Manages a Chronograf
#
# @example
#   include chronograf
class chronograf (
  String $key_resource = '',
  String $resource = '',
  String $software = 'chronograf',
  Enum['present', 'absent'] $gpg_manage = 'present',
  String $gpg_id = '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
  String $gpg_server = 'eu.pool.sks-keyservers.net',
  String $gpg_source = 'https://repos.influxdata.com/.influxdbkey',

  Enum['present', 'absent'] $repository_manage = 'present',
  String $repos_comment = 'Chronograf repository',
  String $repos_location = 'https://repos.influxdata.com/ubuntu/pool/stable/c/chronograf/',
  String $repos_release ='%{::os.distro.codename}',
  String $repos = 'stable',
  Boolean $repos_src = false,
  Boolean $repos_bin = true,
  Enum['1', '0'] $repos_gpgcheck = '1',
  Enum['1', '0'] $repos_enable = '1',

  String $package= 'chronograf',
  Enum['present', 'absent'] $package_manage= 'present',

  String $group = 'chronograf',
  Enum['present', 'absent'] $group_manage = 'present',
  Boolean $group_system = true,
  String $user = 'chronograf',
  Enum['present', 'absent'] $user_manage = 'present',
  Boolean $user_system = true,
  Boolean $user_manage_home = true,
  String $user_home = '/var/lib/',

  String $configuration_path = '/etc/chronograf',
  Enum['directory', 'absent'] $configuration_path_manage = 'directory',
  String $configuration_file = 'chronograf.conf',
  Enum['present', 'absent'] $configuration_file_manage = 'present',
  String $configuration_template= 'chronograf/chronograf.conf.erb',
  String $service_defaults = '/etc/default/chronograf',
  Enum['present', 'absent'] $service_defaults_manage = 'present',
  String $service_default_template = 'chronograf/service-defaults.erb',
  String $service_definition = '/lib/systemd/system/chronograf.service',
  Enum['present', 'absent'] $service_definition_manage = 'present',
  String $service_definition_template = 'chronograf/systemd.service.erb',
  String $service_name = 'chronograf',
  String $service_provider = 'systemd',
  Enum['running', 'absent'] $service_manage = 'running',
  Boolean $service_enable = true,
  Boolean $service_has_status = true,
  Boolean $service_has_restart = true,
){

  include ::chronograf::repo
  include ::chronograf::install
  contain ::chronograf::service

  Class['chronograf::repo'] ~> Class['chronograf::install']
  Class['chronograf::install'] ~> Class['chronograf::service']
}
