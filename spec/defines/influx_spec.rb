# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::connection::influx' do
  let(:title) { 'namevar' }
  let(:params) do
    {
      connection_template: 'chronograf/influx_connection.erb',
      resources_path: '/usr/share/chronograf/resources',
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }
    end
  end
end
