require 'spec_helper'

describe 'chronograf::params', type: :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('chronograf::params')
      end
    end
  end
end
