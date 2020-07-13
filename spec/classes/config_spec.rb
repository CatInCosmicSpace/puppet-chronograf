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
          port: '8888',
          bolt_path: '/var/lib/chronograf/chronograf-v1.db',
          canned_path: '/usr/share/chronograf/canned',
          protoboards_path: '/usr/share/chronograf/protoboards',
          basepath: '',
          status_feed_url: 'https://www.influxdata.com/feed/json',
          defaults_service: {},
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_file('/etc/default/chronograf')
        is_expected.to contain_file('/usr/share/chronograf/resources')
        if facts[:osfamily] == 'Debian'
          is_expected.to contain_file('/lib/systemd/system/chronograf.service')
        end
      end

      context 'on CentOS' do
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
            port: '8888',
            bolt_path: '/var/lib/chronograf/chronograf-v1.db',
            canned_path: '/usr/share/chronograf/canned',
            protoboards_path: '/usr/share/chronograf/protoboards',
            basepath: '',
            status_feed_url: 'https://www.influxdata.com/feed/json',
            defaults_service: {},
          }
        end

        it do
          if facts[:os]['name'] == 'CentOS'
            is_expected.to contain_file('/etc/systemd/system/chronograf.service')
          end
        end
      end
    end
  end
end
