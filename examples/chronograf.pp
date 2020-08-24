include ::chronograf

# is there another influxdata module, which handles already the gpg key and the repo
class { 'chronograf':
  manage_repo             => false,
}

# chronograf handels the gpg key and the repo
#  change /etc/default/chronograf using default_* parameters (single line update with augeas)
class { 'chronograf':
  manage_repo             => true,
  default_host            => '127.0.0.90',
  default_tls_certificate => 'foo-cert',
  default_log_level       => 'info',
  default_use_id_token    => 'false',
}

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

chronograf::connection::kapacitor { 'MyKapacitor':
  ensure       => 'present',
  id           => '10010',
  src_id       => '10010',
  url          => 'http://localhost:9092',
  active       => true,
  organization => 'example_org',
}
