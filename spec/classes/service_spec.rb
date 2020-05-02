# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::service' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          service_name: 'chronograf',
          service_manage: 'running',
          service_enable: true,
          service_has_status: true,
          service_has_restart: true,
          service_provider: 'systemd',
          service_definition: '/lib/systemd/system/chronograf.service',
          service_defaults: '/etc/default/chronograf',
          package: 'chronograf',
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
