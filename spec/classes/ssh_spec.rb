# frozen_string_literal: true

require 'spec_helper'

describe 'ssh' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        it { is_expected.to contain_class('ssh::client') }
        it { is_expected.to contain_class('ssh::server') }
        it { is_expected.to contain_class('ssh::params') }
      end
      context 'dont manage client' do
        let(:params) { { manage_client: false } }

        it { is_expected.not_to contain_class('ssh::client') }
        it { is_expected.to contain_class('ssh::server') }
      end
      context 'dont manage server' do
        let(:params) { { manage_server: false } }

        it { is_expected.to contain_class('ssh::client') }
        it { is_expected.not_to contain_class('ssh::server') }
      end
    end
  end
end
