require 'spec_helper_acceptance'

describe 'chronograf' do
  context 'default install' do
    it 'works with no errors' do
      pp = <<-EOS
        include ::chronograf
        EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      expect(apply_manifest(pp, catch_failures: true).exit_code).to be_zero
    end

    describe package('chronograf') do
      it { is_expected.to be_installed }
    end

    describe service('chronograf') do
      it { is_expected.to be_running }
    end
  end
end
