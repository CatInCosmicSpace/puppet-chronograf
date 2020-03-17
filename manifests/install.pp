# @summary Manages package, group, and user
#
# @example
#   include chronograf::install
class chronograf::install (
  String $package= $chronograf::package,
  Enum['present', 'absent'] $package_manage = $chronograf::package_manage,
  String $group = $chronograf::group,
  Enum['present', 'absent'] $group_manage = $chronograf::group_manage,
  Boolean $group_system = $chronograf::group_system,
  String $user = $chronograf::user,
  Enum['present', 'absent'] $user_manage = $chronograf::user_manage,
  Boolean $user_system = $chronograf::user_system,
  Boolean $user_manage_home = $chronograf::user_manage_home,
  String $user_home = $chronograf::user_home,
){
  package { $package:
    ensure => $package_manage
  }

  group { $group:
    ensure => $group_manage,
    system => $group_system,
  }

  user { $user:
    ensure     => $user_manage,
    gid        => $group,
    home       => "${user_home}${user}",
    managehome => $user_manage_home,
    system     => $user_system,
    require    => Group[$group],
  }
}
