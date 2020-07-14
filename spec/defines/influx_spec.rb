# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::connection::influx' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'testinflux' }
      let(:params) do
        {
          connection_template: 'chronograf/influx_connection.erb',
          resources_path: '/usr/share/chronograf/resources',
          ensure: 'present',
          id: '10000',
          username: 'spectest',
          password: 'spectest',
          url: 'http://localhost:8090',
          type: 'influx',
          insecure_skip_verify: false,
          default: true,
          telegraf: 'telegraf',
          organization: 'specexample_org',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_chronograf__connection__influx('testinflux')
      end
    end
  end
end
