# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include chronograf::repo
class chronograf::repo (
  Boolean $manage_repo = $chronograf::manage_repo,
  String $ensure = $chronograf::ensure,
  String $package_name = $chronograf::package_name,
  String $repo_location = $chronograf::repo_location,
  String $repo_type = $chronograf::repo_type,
){

  if $facts['os']['family'] == 'Debian' {
    if $manage_repo {
      apt::source { 'influxdata':
        comment  => 'InfluxDB repository',
        location => "https://repos.influxdata.com/${facts['os']['name'].downcase}",
        release  => $facts[os][distro][codename],
        repos    => 'stable',
        key      => {
          'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
          'source' => 'https://repos.influxdata.com/influxdb.key',
        },
      }
    }
    include apt
    Class['::apt::update'] -> Package[$package_name]
    package { $package_name:
      ensure => $ensure,
    }
  }

  if $facts['os']['name'] == 'CentOS' {
    if $manage_repo {
      yumrepo { 'influxdata':
        name     => 'influxdata',
        descr    => 'InfluxData Repository',
        enabled  => 1,
        baseurl  => "${repo_location}rhel/${facts['os']['release']['major']}/${facts['os']['architecture']}/${repo_type}",
        gpgkey   => "${repo_location}influxdb.key",
        gpgcheck => 1,
      }

      Yumrepo['influxdata'] -> Package[$package_name]
    }
  }
}
