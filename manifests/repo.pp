# @summary Manages gpg key information and repository, if necessary
#
# @example
#   include chronograf::repo
class chronograf::repo (
  String $key_resource = $chronograf::key_resource,
  String $resource = $chronograf::resource,
  Boolean $manage_repo = $chronograf::manage_repo,
){
  if $manage_repo {

    $keys = lookup('chronograf::gpg_keys', Hash, 'deep', {})
    $repositories = lookup('chronograf::repositories', Hash, 'deep', {})

    if $keys != {} {
      create_resources($key_resource, $keys)
    }
    if $repositories != {} {
      create_resources($resource, $repositories)
    }
  }
}
