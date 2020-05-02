# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      describe 'with default settings' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to have_class_count(5) }
        it { is_expected.to have_resource_count(7) }

        it { is_expected.to contain_class('chronograf::repo').that_comes_before('Class[chronograf::install]') }
        it { is_expected.to contain_class('chronograf::install').that_comes_before(['Class[chronograf::config]', 'Class[chronograf::service]']) }
      end
    end
  end
end
