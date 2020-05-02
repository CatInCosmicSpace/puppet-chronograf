# frozen_string_literal: true

require 'spec_helper'

describe 'chronograf::repo' do
  on_supported_os.each do
    context 'with all defaults' do
      let :params do
        {
          key_resource: '',
          resource: '',
          keys: {},
          repositories: {},
          manage_repo: false,
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
