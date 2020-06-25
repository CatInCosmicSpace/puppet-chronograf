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
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
