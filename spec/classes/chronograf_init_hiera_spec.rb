# frozen_iteral: true

require 'spec_helper'

describe 'chronograf', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let(:title) { 'test connection hiera lookup' }

      it { is_expected.to create_class('chronograf') }

      it do
        is_expected.to contain_chronograf__connection__influx('MyInfluxDB').with(
          'ensure' => 'present',
          'id' => '10000',
          'username' => 'telegraf',
          'password' => 'metricsmetricsmetrics',
          'url' => 'http://localhost:8086',
          'type' => 'influx',
          'insecure_skip_verify' => false,
          'default' => true,
          'telegraf' => 'telegraf',
          'organization' => 'example_org',
          'influx_connection_template' => 'chronograf/influx_connection.erb',
          'kapacitor_connection_template' => 'chronograf/kapacitor_connection.erb',
        )
      end
    end
  end
end
