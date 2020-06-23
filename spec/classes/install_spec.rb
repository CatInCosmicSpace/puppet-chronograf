# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::install' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :params do
        {
          group: 'chronograf',
          group_manage: 'present',
          group_system: true,
          user: 'chronograf',
          user_manage: 'present',
          user_system: true,
          user_manage_home: true,
          user_home: '/var/lib/',
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
