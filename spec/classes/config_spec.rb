# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          service_defaults: '/etc/default/chronograf',
          service_defaults_template: 'chronograf/service-defaults.erb',
          service_definition: '/lib/systemd/system/chronograf.service',
          service_definition_template: 'chronograf/systemd.service.erb',
          resources_path: '/usr/share/chronograf/resources',
          user: 'chronograf',
          group: 'chronograf',
          host: '0.0.0.0',
          port: 8888,
          bolt_path: '/var/lib/chronograf/chronograf-v1.db',
          canned_path: '/usr/share/chronograf/canned',
          protoboards_path: '/usr/share/chronograf/protoboards',
          basepath: '/usr/share/chronograf/base',
          status_feed_url: 'https://www.influxdata.com/feed/json',
          default_host: 'UNSET',
          default_port: 'UNSET',
          default_tls_certificate: 'UNSET',
          default_token_secret: 'UNSET',
          default_log_level: 'UNSET',
          default_public_url: 'UNSET',
          default_generic_client_id: 'UNSET',
          default_generic_client_secret: 'UNSET',
          default_generic_auth_url: 'UNSET',
          default_generic_token_url: 'UNSET',
          default_use_id_token: 'UNSET',
          default_jwks_url: 'UNSET',
          default_generic_api_url: 'UNSET',
          default_generic_api_key: 'UNSET',
          default_generic_scopes: 'UNSET',
          default_generic_domains: 'UNSET',
          default_generic_name: 'UNSET',
          default_google_client_id: 'UNSET',
          default_google_client_secret: 'UNSET',
          default_google_domains: 'UNSET',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_file('/usr/share/chronograf/resources')
        if facts[:os]['family'] == 'Debian'
          is_expected.to contain_file('/lib/systemd/system/chronograf.service')
        end
      end

      context 'on RedHat' do
        let :params do
          {
            service_defaults: '/etc/default/chronograf',
            service_defaults_template: 'chronograf/service-defaults.erb',
            service_definition: '/etc/systemd/system/chronograf.service',
            service_definition_template: 'chronograf/systemd.service.erb',
            resources_path: '/usr/share/chronograf/resources',
            user: 'chronograf',
            group: 'chronograf',
            host: '0.0.0.0',
            port: 8888,
            bolt_path: '/var/lib/chronograf/chronograf-v1.db',
            canned_path: '/usr/share/chronograf/canned',
            protoboards_path: '/usr/share/chronograf/protoboards',
            basepath: '/usr/share/chronograf/base',
            status_feed_url: 'https://www.influxdata.com/feed/json',
            default_host: 'UNSET',
            default_port: 'UNSET',
            default_tls_certificate: 'UNSET',
            default_token_secret: 'UNSET',
            default_log_level: 'UNSET',
            default_public_url: 'UNSET',
            default_generic_client_id: 'UNSET',
            default_generic_client_secret: 'UNSET',
            default_generic_auth_url: 'UNSET',
            default_generic_token_url: 'UNSET',
            default_use_id_token: 'UNSET',
            default_jwks_url: 'UNSET',
            default_generic_api_url: 'UNSET',
            default_generic_api_key: 'UNSET',
            default_generic_scopes: 'UNSET',
            default_generic_domains: 'UNSET',
            default_generic_name: 'UNSET',
            default_google_client_id: 'UNSET',
            default_google_client_secret: 'UNSET',
            default_google_domains: 'UNSET',
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_file('/etc/systemd/system/chronograf.service')
          end
        end
      end
    end
  end
end
