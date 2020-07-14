# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include chronograf::repo
class chronograf::repo (
  Boolean $manage_repo = $chronograf::manage_repo,
  String $ensure = $chronograf::ensure,
  String $package_name = $chronograf::package_name,
  Stdlib::HTTPSUrl $repo_location = $chronograf::repo_location,
  String $repo_type = $chronograf::repo_type,
){

  case $facts['os']['family'] {
    'Debian': {
      if $manage_repo {
        apt::source { 'influxdata':
          comment  => 'InfluxDB repository',
          location => "${repo_location}${facts['os']['name'].downcase}",
          release  => $facts[os][distro][codename],
          repos    => $repo_type,
          key      => {
            'id'     => '05CE15085FC09D18E99EFB22684A14CF2582E0C5',
            'source' => "${repo_location}influxdb.key",
          },
        }
      }
    }

    'RedHat': {
      if $manage_repo {
        yumrepo { 'influxdata':
          name     => 'influxdata',
          descr    => 'InfluxData Repository',
          enabled  => 1,
          baseurl  => "${repo_location}rhel/${facts['os']['release']['major']}/${facts['os']['architecture']}/${repo_type}",
          gpgkey   => "${repo_location}influxdb.key",
          gpgcheck => 1,
        }
        package { $package_name:
          ensure => $ensure,
        }
      }
    }
    default: {
      notice("This os ${facts['os']['family']} is not supported")
    }
  }
}
