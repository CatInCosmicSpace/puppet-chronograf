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

Installs, configures and manages [Chronograf](https://github.com/influxdata/chronograf), the monitoring and visualization UI of the Tick stack.

## Setup

### What chronograf affects

Default configuration

- manages GPG key, repository (default: `manage_repo = true` )
  - default: `repo_location = https://repos.influxdata.com/` and `repo_type = 'stable'`

- manages package

- manages directories and configuration files (referring to templates)

  * Debian: `/lib/systemd/system/chronograf.service`
  * CentOS: `/etc/systemd/system/chronograf.service`

  * `/etc/default/chronograf`

- starts service "chronograf" immediately (default: `manage_service = true`)

- set up connection to influx and kapacitor upon request, also based on templates

  * `/usr/share/chronograf/resources/`

### Setup Requirements

For an extensive list of requirements, see `metadata.json`.

### Beginning with chronograf

The module comes along with several configuration files (see templates).
Change configuration settings in according hiera level or via hash.

- `service-defaults.erb`
    - following keys are supported to be added in single line mode
      *  host = '0.0.0.0'
      *  port = 8888
      *  tls_certificate
      *  token_secret
      *  log_level ['error','warn','info','debug']
      *  public_url
      *  generic_client_id
      *  generic_client_secret
      *  generic_auth_url
      *  generic_token_url
      *  use_id_token ['true','false']
      *  jwks_url
      *  generic_api_url
      *  generic_api_key
      *  generic_scopes
      *  generic_domains
      *  generic_name
      *  google_client_id
      *  google_client_secret
      *  google_domains

- `systemd.service.erb`

- With two defines setup the connection to influx and kapacitor.

Please refer to [Chronograf documentation](https://www.influxdata.com/time-series-platform/chronograf/)
for the defaults used.

## Usage

### In combination with other influxdata module

- when one of the other influxdata modules already handles GPG keys and repository

```
class { 'chronograf':
  manage_repo => false,
}
```

- when chronograf shall handle GPG keys and repository

```
class { 'chronograf':
  manage_repo => true,
}
```

### Example

```
class { 'chronograf':
  manage_repo     => true,
  host            => '127.0.0.90',
  tls_certificate => 'cert-bar',
  log_level       => 'info',
  use_id_token    => 'false',
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
```

## Reference

Please see document `REFERENCE.md`.

## Limitations

   For an extensive list of supported operating systems, see `metadata.json`.

## Development

-   pdk-version     1.18.1
-   template-url    pdk-default 1.18.1
-   template-ref    tags/1.18.1-0-g3d2e75c

## Release Notes/Contributors/Etc.

-   module:     kogitoapp-chronograf
-   version:    0.1.0
-   author:     Kogito UG <hello@kogito.network>
-   summary:    Module for configuring Chronograf
-   license:    Apache-2.0
-   source:     https://github.com/kogitoapp/puppet-chronograf
