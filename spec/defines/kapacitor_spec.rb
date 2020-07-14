# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::connection::kapacitor' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'testkapacitor' }
      let(:params) do
        {
          connection_template: 'chronograf/influx_connection.erb',
          resources_path: '/usr/share/chronograf/resources',
          ensure: 'present',
          id: '10000',
          src_id: '10000',
          url: 'http://localhost:9098',
          active: true,
          organization: 'specexample_org',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_chronograf__connection__kapacitor('testkapacitor')
      end
    end
  end
end
