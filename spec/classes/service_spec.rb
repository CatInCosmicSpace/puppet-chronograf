# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let :params do
        {
          service_name: 'chronograf',
          service_ensure: 'running',
          service_enable: true,
          service_has_status: true,
          service_has_restart: true,
          service_provider: 'systemd',
          manage_service: true,
          service_defaults: '/etc/default/chronograf',
          service_definition: '/lib/systemd/system/chronograf.service',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('chronograf::service')
        is_expected.to contain_service('chronograf').that_subscribes_to(['File[/etc/default/chronograf]'])
        if facts[:os]['family'] == 'Debian'
          is_expected.to contain_service('chronograf').that_subscribes_to(['File[/lib/systemd/system/chronograf.service]'])
        end
      end

      context 'on RedHat' do
        let :params do
          {
            service_name: 'chronograf',
            service_ensure: 'running',
            service_enable: true,
            service_has_status: true,
            service_has_restart: true,
            service_provider: 'systemd',
            manage_service: true,
            service_defaults: '/etc/default/chronograf',
            service_definition: '/etc/systemd/system/chronograf.service',
          }
        end

        it do
          if facts[:os]['family'] == 'RedHat'
            is_expected.to contain_service('chronograf').that_subscribes_to(['File[/etc/systemd/system/chronograf.service]'])
          end
        end
      end
    end
  end
end
