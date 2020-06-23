# @summary Manages the service
#
# @example
#   include chronograf::service
class chronograf::service (
  String $service_name = $chronograf::service_name,
  Enum['running', 'absent'] $service_ensure = $chronograf::service_ensure,
  Boolean $service_enable = $chronograf::service_enable,
  Boolean $service_has_status = $chronograf::service_has_status,
  Boolean $service_has_restart = $chronograf::service_has_restart,
  String $service_provider = $chronograf::service_provider,
  Boolean $manage_service = $influxdb::manage_service,
){
  if $manage_service {
    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      hasstatus  => $service_has_status,
      hasrestart => $service_has_restart,
      provider   => $service_provider,
    }
  }
}

