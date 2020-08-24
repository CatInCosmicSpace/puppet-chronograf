#include ::chronograf

# is there another influxdata module, which handles already the gpg key and the repo
class { 'chronograf':
  manage_repo             => false,
}

# chronograf handels the gpg key and the repo
class { 'chronograf':
  manage_repo     => true,
  host            => '127.0.0.90',
  tls_certificate => 'cert-bar',
  log_level       => 'info',
  use_id_token    => 'false',
}

# chronograf handels the gpg key and the repo
#  change /etc/default/chronograf using * parameters (single line update with augeas)
class { 'chronograf':
  manage_repo     => true,
  host            => '127.0.0.90',
  tls_certificate => 'foo-cert',
  log_level       => 'info',
  use_id_token    => 'false',
}

# setup a connection to influxdb
chronograf::connection::influx { 'MyInfluxDB':
  ensure               => 'present',
  id                   => '10000',
  username             => 'telegraf',
  password             => 'metricsmetricsmetrics',
  url                  => 'http://localhost:8086',
  type                 => 'influx',
  insecure_skip_verify => false,
  default              => true,
  telegraf             => 'telegraf',
  organization         => 'example_org',
}

# setup a connection to kapacitorw
chronograf::connection::kapacitor { 'MyKapacitor':
  ensure       => 'present',
  id           => '10010',
  src_id       => '10010',
  url          => 'http://localhost:9092',
  active       => true,
  organization => 'example_org',
}
