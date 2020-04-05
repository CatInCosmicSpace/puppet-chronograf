# Puppet module to manage Chronograf



#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with chronograf](#setup)
    * [What chronograf affects](#what-chronograf-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with chronograf](#beginning-with-chronograf)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

Installs, configures and manages [Chronograf](https://github.com/influxdata/chronograf),the monitoring and visualization UI of the Tick stack.

## Setup

### What chronograf affects

Default configuration

- manages GPG key, repository (use `$manage_repo` to deactivate when another influxdata module takes the lead)

- manages package

- manages user and group chronograf

- manages directories and configuration files (referring to templates)

  * /lib/systemd/system/chronograf.service

  * /etc/default/chronograf

- starts service "chronograf" immediately
    service subscribes on "package", "chronograf.service" and "defaults"

- set up connection to influx and kapacitor upon request, also based on templates

  * /usr/share/chronograf/resources/*

### Setup Requirements **OPTIONAL**

-   `puppetlabs/apt`
    version `>= 2.0.0 < 8.0.0`

-   `puppetlabs/concat`
    version `>= 5.0.0 < 7.0.0`

-   `puppetlabs/stdlib`
    version `>= 4.25.0 < 7.0.0`

-   `puppetlabs/translate`
    version `>= 1.0.0 < 3.0.0`

-   `puppet`
    version `>= 5.5.8 < 7.0.0`

For an extensive list of requirements, see `metadata.json`.

### Beginning with chronograf

The module comes along with several configuration files, which you can find in
`templates`. Change configuration settings in according Hiera level.

- `service-defaults.erb`
- `systemd.service.erb`

You will also find in `templates` connection settings to influx and kapacitor.
Change configuration settings in according Hiera level. Or provide them via a hash.

Please refer to [Chronograf documentation](https://www.influxdata.com/time-series-platform/chronograf/)
for the defaults used.

## Usage

### Without any connections to influx or kapacitor:

```
include ::chronograf
```

### With connections to influx and kapacitor:

```
class { 'chronograf':

}

chronograf::connection::influx{'MyInfluxDB':
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

chronograf::connection::kapacitor{'MyKapacitor':
  ensure       => 'present',
  id           => '10010',
  src_id       => '10010',
  url          => 'http://localhost:9092',
  active       => true,
  organization => 'example_org',
}
```

### In combination with other influxdata module

* when one of the other influxdata modules already handles GPG keys and repository

```
class { 'chronograf':
  manage_repo => false,
}
```

* when chronograf shall handle GPG keys and repository

```
class { 'chronograf':
  manage_repo => true,
}
```

## Reference

Please see document `REFERENCE.md`.

## Limitations

   This module uses "Hiera".

   For an extensive list of supported operating systems, see `metadata.json`.

## Development

-   pdk-version     1.17.0
-   template-url    pdk-default 1.17.0
-   template-ref    tags/1.17.0-0-g0bc522e

## Release Notes/Contributors/Etc. **Optional**

-   module:     kogitoapp-chronograf
-   version:    0.1.0
-   author:     Kogito UG <hello@kogito.network>
-   summary:    Module for configuring InfluxDB
-   license:    Apache-2.0
-   source:     https://github.com/kogitoapp/puppet-chronograf
