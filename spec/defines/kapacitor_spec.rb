# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::connection::kapacitor' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'MyInfluxDB' }
      let(:params) do
        {
          connection_template: 'chronograf/influx_connection.erb',
          resources_path: '/usr/share/chronograf/resources',
        }
      end

      it do
        is_expected.to compile.with_all_deps
      end
    end
  end
end
