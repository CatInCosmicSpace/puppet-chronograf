# @summary Manages package, group, and user
#
# @example
#   include chronograf::install
class chronograf::install (
  String $group = $chronograf::group,
  Boolean $group_system = $chronograf::group_system,
  String $user = $chronograf::user,
  Boolean $user_system = $chronograf::user_system,
  Boolean $user_manage_home = $chronograf::user_manage_home,
  String $user_home = $chronograf::user_home,
){

  group { $group:
    ensure => present,
    system => $group_system,
  }

  user { $user:
    ensure     => present,
    gid        => $group,
    home       => "${user_home}${user}",
    managehome => $user_manage_home,
    system     => $user_system,
    require    => Group[$group],
  }
}
