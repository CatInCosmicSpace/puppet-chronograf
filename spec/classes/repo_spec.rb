# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::repo' do
    on_supported_os.each do |os, os_facts|
      context "on #{os}" do
        let(:facts) { os_facts }
        let :params do
          {
            'manage_repo' => true,
            'package_name' => 'chronograf',
            'ensure' => 'present',
            'repo_location' => 'https://repos.influxdata.com/',
            'repo_type' => 'stable',
          }
        end

        it do
          is_expected.to compile.with_all_deps
          is_expected.to contain_class('chronograf::repo')
          is_expected.to contain_package('chronograf')

          if facts[:osfamily] == 'Debian'
            is_expected.to contain_class('apt')
          end

          if facts[:os]['name'] == 'CentOS'
            is_expected.to contain_yumrepo('influxdata')
          end
        end
      end
    end
  end
