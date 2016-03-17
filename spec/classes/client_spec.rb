require 'spec_helper'

describe 'ssh::client' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        it { is_expected.to contain_file_line('CheckHostIP').with(
          :ensure => 'absent',
          :line   => 'CheckHostIP no',
          :path   => '/etc/ssh/ssh_config'
        )}
      end

      context 'enable CheckHostIP' do
        let(:params) {{ :check_host_ip => true }}
        it { is_expected.to contain_file_line('CheckHostIP').with(
          :ensure => 'present',
          :line   => 'CheckHostIP no',
          :path   => '/etc/ssh/ssh_config'
        )}
      end

      context 'pass incorrect params' do
        let(:params) {{ :check_host_ip => 'foo' }}
        it do
          expect {
            subject.call
          }.to raise_error(Puppet::Error)
        end
      end

      case facts[:operatingsystem]
      when 'Ubuntu'
        it { is_expected.to contain_package('openssh-client').with_ensure(
          'present') }
      end
    end
  end
end
