# @summary Manages package, group, and user
#
# @example
#   include chronograf::install
class chronograf::install (
  String $ensure = $chronograf::ensure,
  String $package_name = $chronograf::package_name,
){
  case $facts['os']['family'] {
  'Debian': {
    include apt
    Class['::apt::update'] -> Package[$package_name]
    package { $package_name:
      ensure => $ensure,
    }
  }
    default: {
      # do nothing
    }
  }
}
