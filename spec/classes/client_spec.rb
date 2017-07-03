# frozen_string_literal: true

require 'spec_helper'

describe 'ssh::client' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with defaults' do
        it do
          is_expected.to contain_file_line('CheckHostIP').with(
            ensure: 'absent',
            line: '    CheckHostIP no',
            path: '/etc/ssh/ssh_config'
          )
        end
      end

      context 'enable CheckHostIP' do
        let(:params) { { check_host_ip: false } }

        it do
          is_expected.to contain_file_line('CheckHostIP').with(
            ensure: 'present',
            line: '    CheckHostIP no',
            path: '/etc/ssh/ssh_config'
          )
        end
      end

      context 'pass incorrect params' do
        let(:params) { { check_host_ip: 'foo' } }

        it { expect { subject.call }.to raise_error(Puppet::Error) }
      end

      case facts[:operatingsystem]
      when 'Ubuntu'
        it do
          is_expected.to contain_package(
            'openssh-client'
          ).with_ensure('present')
        end
      end
    end
  end
end
