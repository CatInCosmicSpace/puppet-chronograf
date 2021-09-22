# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('chronograf')
        is_expected.to contain_class('chronograf::repo').that_comes_before('Class[chronograf::install]')
        is_expected.to contain_class('chronograf::install').that_comes_before(['Class[chronograf::config]', 'Class[chronograf::service]'])
        is_expected.to contain_class('chronograf::config')
        is_expected.to contain_class('chronograf::service')
      end
    end
  end
end
