# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::config' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          service_defaults: '/etc/default/chronograf',
          service_definition: '/lib/systemd/system/chronograf.service',
          service_definition_template: 'chronograf/systemd.service.erb',
          resources_path: '/fubar/resources',
          user: 'foo',
          group: 'bar',
          bolt_path: '/fubar/chronograf-v1.db',
          canned_path: '/fubar/canned',
          protoboards_path: '/fubar/protoboards',
          basepath: '/fubar/base',
          status_feed_url: 'https://www.influxdata.com/feed/json',
          host: '1.2.3.4',
          port: 8888,
          tls_certificate: 'UNSET',
          token_secret: 'UNSET',
          log_level: 'UNSET',
          public_url: 'UNSET',
          generic_client_id: 'UNSET',
          generic_client_secret: 'UNSET',
          generic_auth_url: 'UNSET',
          generic_token_url: 'UNSET',
          use_id_token: 'UNSET',
          jwks_url: 'UNSET',
          generic_api_url: 'UNSET',
          generic_api_key: 'UNSET',
          generic_scopes: 'UNSET',
          generic_domains: 'UNSET',
          generic_name: 'UNSET',
          google_client_id: 'UNSET',
          google_client_secret: 'UNSET',
          google_domains: 'UNSET',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_file('/fubar/resources').
          with(ensure: 'directory')
        if facts[:os]['family'] == 'Debian'
          is_expected.to contain_file('/lib/systemd/system/chronograf.service').
            with(ensure: 'present').
            with_content(%r{User=foo}).
            with_content(%r{Group=bar}).
            with_content(%r{Environment=\"BOLT_PATH=\/fubar\/chronograf-v1.db\"}).
            with_content(%r{Environment\="PROTOBOARDS_PATH=\/fubar\/protoboards\"}).
            with_content(%r{Environment=\"RESOURCES_PATH=\/fubar\/resources\"}).
            with_content(%r{ExecStart=\/usr\/bin\/chronograf \$CHRONOGRAF_OPTS})
        end
      end

      context 'on RedHat' do
        let :params do
          {
            service_defaults: '/etc/default/chronograf',
            service_definition: '/etc/systemd/system/chronograf.service',
            service_definition_template: 'chronograf/systemd.service.erb',
            resources_path: '/barfoot/resources',
            user: 'drill',
            group: 'sergeant',
            bolt_path: '/barfoot/chronograf-v1.db',
            canned_path: '/barfoot/canned',
            protoboards_path: '/barfoot/protoboards',
            basepath: '/barfoot/chronograf/base',
            status_feed_url: 'https://www.influxdata.com/feed/json',
            host: '1.2.3.4',
            port: 8888,
            tls_certificate: 'UNSET',
            token_secret: 'UNSET',
            log_level: 'UNSET',
            public_url: 'UNSET',
            generic_client_id: 'UNSET',
            generic_client_secret: 'UNSET',
            generic_auth_url: 'UNSET',
            generic_token_url: 'UNSET',
            use_id_token: 'UNSET',
            jwks_url: 'UNSET',
            generic_api_url: 'UNSET',
            generic_api_key: 'UNSET',
            generic_scopes: 'UNSET',
            generic_domains: 'UNSET',
            generic_name: 'UNSET',
            google_client_id: 'UNSET',
            google_client_secret: 'UNSET',
            google_domains: 'UNSET',
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_file('/etc/systemd/system/chronograf.service').
              with(ensure: 'present').
              with_content(%r{User=drill}).
              with_content(%r{Group=sergeant}).
              with_content(%r{Environment=\"BOLT_PATH=\/barfoot\/chronograf-v1.db\"}).
              with_content(%r{Environment\="PROTOBOARDS_PATH=\/barfoot\/protoboards\"}).
              with_content(%r{Environment=\"RESOURCES_PATH=\/barfoot\/resources\"}).
              with_content(%r{ExecStart=\/usr\/bin\/chronograf \$CHRONOGRAF_OPTS})
          end
        end
      end

      context 'augeas' do
        let :params do
          {
            service_defaults: '/etc/default/chronograf',
            service_definition: '/lib/systemd/system/chronograf.service',
            service_definition_template: 'chronograf/systemd.service.erb',
            resources_path: '/fubar/resources',
            user: 'foo',
            group: 'bar',
            bolt_path: '/fubar/chronograf-v1.db',
            canned_path: '/fubar/canned',
            protoboards_path: '/fubar/protoboards',
            basepath: '/fubar/base',
            status_feed_url: 'https://www.influxdata.com/feed/json',
            host: '1.2.1.2',
            port: 1234,
            tls_certificate: 'UNSET',
            token_secret: 'UNSET',
            log_level: 'info',
            public_url: 'UNSET',
            generic_client_id: 'UNSET',
            generic_client_secret: 'UNSET',
            generic_auth_url: 'UNSET',
            generic_token_url: 'UNSET',
            use_id_token: 'UNSET',
            jwks_url: 'UNSET',
            generic_api_url: 'UNSET',
            generic_api_key: 'UNSET',
            generic_scopes: 'UNSET',
            generic_domains: 'UNSET',
            generic_name: 'UNSET',
            google_client_id: 'UNSET',
            google_client_secret: 'UNSET',
            google_domains: 'UNSET',
          }
        end

        it 'has augeas resources' do
          is_expected.to contain_augeas('set_log_level').
            with_context('/files/etc/default/chronograf').
            with_changes(['set LOG_LEVEL info']).
            with_incl('/etc/default/chronograf').
            with_lens('Shellvars.lns')
          is_expected.to contain_augeas('set_host').
            with_context('/files/etc/default/chronograf').
            with_changes(['set HOST 1.2.1.2']).
            with_incl('/etc/default/chronograf').
            with_lens('Shellvars.lns')
          is_expected.to contain_augeas('set_port').
            with_context('/files/etc/default/chronograf').
            with_changes(['set PORT 1234']).
            with_incl('/etc/default/chronograf').
            with_lens('Shellvars.lns')
        end

        it 'has no augeas resources' do
          is_expected.not_to contain_augeas('set_google_domains')
          is_expected.not_to contain_augeas('set_generic_api_url')
        end
      end
    end
  end
end
