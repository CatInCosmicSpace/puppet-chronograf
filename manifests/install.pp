# @summary Manages package, group, and user
#
# @example
#   include chronograf::install
class chronograf::install (
  String $ensure = $chronograf::ensure,
  String $package_name = $chronograf::package_name,
  Boolean $manage_repo = $chronograf::manage_repo,
){
  if ! $manage_repo {
    package { $package_name:
      ensure => $ensure,
    }
  }
}
