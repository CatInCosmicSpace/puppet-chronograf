# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:pre_condition) do
        <<-PUPPET
        yumrepo { ['influxdata']: }
        PUPPET
      end

      context 'ensure present' do
        let :params do
          {
            'ensure' => 'present',
            'package_name' => 'chronograf',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_class('chronograf::install')
          is_expected.to contain_package('chronograf')
            .with(ensure: 'present')
          case facts[:os]['family']
          when 'Debian'
            is_expected.to contain_class('apt')
          end
        end
      end

      context 'ensure absent' do
        let :params do
          {
            'ensure' => 'absent',
            'package_name' => 'chronograf',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_package('chronograf')
            .with(ensure: 'absent')
        end
      end
    end
  end
end
