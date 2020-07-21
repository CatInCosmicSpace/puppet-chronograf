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
          organization: 'specexample.org',
        }
      end

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_chronograf__connection__influx('testinflux')
        is_expected.to contain_file('/usr/share/chronograf/resources/testinflux.src').
          with_content(%r{\"id\": \"10000\",\n}).
          with_content(%r{\"name\": \"testinflux\",\n}).
          with_content(%r{\"username\": \"spectest\",\n}).
          with_content(%r{\"password\": \"spectest\",\n}).
          with_content(%r{\"url\": \"http:\/\/localhost:8090\",\n}).
          with_content(%r{\"type\": \"influx\",\n}).
          with_content(%r{\"insecureSkipVerify\": false,\n}).
          with_content(%r{\"default\": true,\n}).
          with_content(%r{\"telegraf\": \"telegraf\",\n}).
          with_content(%r{\"organization\": \"specexample.org\"\n})
      end
    end
  end
end
